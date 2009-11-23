class Artist

  attr_reader :path, :filename

  def initialize(path)
    @path, @filename = path, File.basename(path)
  end
  
  def each_album(artist_pattern='*', &block)
    Dir.glob(File.join(@path, artist_pattern)).each {|file| yield Album.new(file)}
  end
  
  def check
    puts self
  end
  
  def normalize
    puts self
  end
  
  def to_s
    @filename
  end
  
end
