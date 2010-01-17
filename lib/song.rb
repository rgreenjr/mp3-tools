require 'cgi'
require 'mp3info'

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
      delete_extraneous_tags
      delete_tag_1
      print_notes
    end
  end
  
  def tag(name)
    @info.tag2[name]
  end
  
  def title
    tag('TIT2')
  end
  
  def title=(value)
    write_tag('TIT2', value)
  end
  
  def artist
    tag('TPE1')
  end
  
  def album
    tag('TALB')
  end
  
  def comments
    tag('COMM')
  end
  
  def genre
    tag('TCON')
  end
  
  def picture
    return nil unless tag('APIC')
    @picture ||= Picture.new(tag('APIC'))
  end
  
  def has_title?
    !title.to_s.remove_extraneous_spaces.empty?
  end

  def has_genre?
    !genre.to_s.empty?
  end

  def classical?
    genre == "(32)" || genre == "Classical"
  end
  
  def to_s
    "    #{@filename}"
  end
  
  private

  def check_tags
    @notes << "redundant id3v1 tag" if @info.hastag1?
    @notes << "missing id3v2 tag" unless @info.hastag2?
    @notes << "missing title" unless has_title?
    @notes << "missing genre" unless has_genre?
    @info.tag2.each { |key, value| @notes << "extraneous tag: #{key} = #{value}" if Frame.extraneous?(key) }
    @info.tag2.each { |key, value| @notes << "unknown tag:  #{key.inspect} = #{value}" unless Frame.known?(key) }
  end
  
  def check_picture
    # add check for more than one picture
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
  
  def delete_extraneous_tags
    @info.tag2.each do |key, value|
      if Frame.extraneous?(key)
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