class Album
  
  attr_reader :path, :filename

  def initialize(path)
    @path, @filename = path, File.basename(path)
  end

  def each_song(song_pattern='*', &block)
    Dir.glob(File.join(escaped_path, "#{song_pattern}.mp3")).each {|file| yield Song.new(file)}
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