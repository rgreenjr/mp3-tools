class Song
  
  attr_accessor :path

  def initialize(path)
    @path = path
  end

  def open(&block)
    Mp3Info.open(@path) do |info|
      @info = info
      # raise "Missing ID3v2 title: #{path}" unless has_title?
      yield self
    end
  end

  def normalize
    normalize_title
    clear_comments
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
    self.title = str
  end
  
  def normalize_album
    str = self.album
    str = str.remove_extraneous_spaces
    str = str.downcase_prepositions
    self.album = str
  end
  
  def clear_comments
    if comments != nil
      puts "  * deleting comment: #{comments}"
      @info.tag2.delete('COMM')
    end
  end

  def title
    @info.tag2.TIT2
  end

  def title=(value)
    write_tag('TIT2', value)
  end

  def artist
    @info.tag.TPE1
  end

  def artist=(value)
    write_tag('TPE1', value)
  end
  
  def album
    @info.tag.album
  end

  def album=(value)
    write_tag('TALB', value)
  end
  
  def comments
    @info.tag2.COMM
  end

  def comments=(value)
    write_tag('COMM', value)
  end

  def has_art?
    @info.tag2.APIC != nil
  end

  def classical?
    @info.tag2.TCON == "(32)" || @info.tag2.TCON == "Classical"
  end

  def to_s
    "    #{title}"
  end
  
  private
  
  def write_tag(tag, value)
    return if value == @info.tag2[tag]
    puts "    * #{@info.tag2[tag]}\n   ** #{value}"
    @info.tag2[tag] = value
  end

end