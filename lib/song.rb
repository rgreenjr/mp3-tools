require 'cgi'

class Song
  
  attr_reader :path, :filename

  def initialize(path)
    @path, @filename, @notes = path, File.basename(path), []
  end

  def open(&block)
    Mp3Info.open(@path) do |info|
      @info = info
      yield self
    end
  end
  
  def check
    open do
      @notes.clear
      check_title
      check_tags
      check_picture
      print_notes
      Log.save
    end
  end
  
  def normalize
    open do
      @notes.clear
      self.title = normalize_title
      delete_comments
      delete_rejected_tags
      delete_tag_1
      print_notes
    end
  end
  
  def title
    @info.tag2.TIT2
  end

  def title=(value)
    write_tag('TIT2', value)
  end

  def artist
    @info.tag2.TPE1
  end

  def album
    @info.tag2.TALB
  end

  def comments
    @info.tag2.COMM
  end

  def genre
    @info.tag2.TCON
  end

  def picture
    return nil unless @info.tag2.APIC
    if @info.tag2.APIC.class == Array
      @picture ||= Picture.new(@info.tag2.APIC.first)
    else
      @picture ||= Picture.new(@info.tag2.APIC)
    end
  end
  
  def has_title?
    !title.to_s.remove_extraneous_spaces.empty?
  end

  def has_genre?
    !genre.to_s.empty?
  end

  def classical?
    @info.tag2.TCON == "(32)" || @info.tag2.TCON == "Classical"
  end
  
  def to_s
    "    #{@filename}"
  end
  
  private

  def check_tags
    @notes << "has id3v1 tag" if @info.hastag1?
    @notes << "missing id3v2 tag" unless @info.hastag2?
    @notes << "missing title" unless has_title?
    @notes << "missing genre" unless has_genre?
    @info.tag2.each { |key, value| @notes << "rejected tag: #{key} = #{value}" unless Tag.admit?(key) }
    @info.tag2.each { |key, value| @notes << "unknown tag:  #{key.inspect} = #{value}" unless Tag.known?(key) }
  end
  
  def check_picture
    return if picture && !picture.undersized?
    @notes << "missing picture" unless picture
    @notes << "undersized picture: #{picture}" if picture && picture.undersized?
    Log.picture_error(artist, album)
  end
  
  def check_title
    str = normalize_title
    if title != str
      @notes << "normalize title: #{str}"
    end
  end
  
  def normalize_title
    str = self.title
    str = str.remove_extraneous_spaces
    str = str.downcase_prepositions
    if classical?
      str = str.normalize_key_signature
      str = str.romanize_movement_numbers
      str = str.normalize_piece_number
      str = str.normalize_opus_number
    end
    str
  end
  
  def delete_comments
    if comments != nil
      @notes << "deleting comment: #{comments}"
      @info.tag2.delete('COMM')
    end
  end
  
  def delete_rejected_tags
    @info.tag2.each do |key, value|
      if Tag.reject?(key)
        @notes << "deleting tag: #{key} = #{value}"
        @info.tag2.delete(key)
      end
    end
  end
  
  def delete_tag_1
    if @info.hastag1? && @info.hastag2?
      @notes << "deleting id3v1 tag"
      @info.removetag1
    end
  end

  def write_tag(tag, value)
    return if value == @info.tag2[tag]
    puts "    * #{@info.tag2[tag]}\n   ** #{value}"
    @info.tag2[tag] = value
  end
  
  def print_notes
    unless @notes.empty?
      puts "    #{title || @filename}"
      @notes.each { |msg| Log.print(msg) }
    end
  end
  
end