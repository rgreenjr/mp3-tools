class Album
  
  attr_reader :path, :filename, :artist

  def initialize(path, artist)
    @path, @filename, @artist = path, File.basename(path), artist
  end

  def each_song(title_pattern='*', &block)
    Dir.glob(File.join(escaped_path, "#{title_pattern}.mp3")).each {|file| yield Song.new(file, self)}
  end
  
  def check
    puts self
  end
  
  def normalize
    puts self
  end
  
  def to_s
    "  #{@filename}"
  end
  
  def escaped_path
    @path.gsub(/\[/, '\[').gsub(/\]/, '\]')
  end
  
end
                          