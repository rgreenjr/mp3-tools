class Artist

  attr_reader :path, :filename

  def initialize(path)
    @path, @filename = path, File.basename(path)
  end
  
  def each_album(artist_pattern='*', &block)
    Dir.glob(File.join(@path, artist_pattern)).each {|file| yield Album.new(file)}
  end
  
  def check(album_pattern='*', song_pattern='*')
    puts self
    each_album(album_pattern) { |album| album.check(song_pattern) }
  end
  
  def to_s
    @filename
  end
  
end
