class Library

  attr_accessor :path, :interactive, :artist_pattern, :album_pattern, :song_pattern
  
  def self.default(options={})
    if `hostname`.strip == 'whiskey.local'
      self.new("/Volumes/Media/iTunes Media/Music", options)
    else
      self.new("/Users/rgreen/Music/iTunes/iTunes Media/Music", options)
    end
  end

  def initialize(path, options={})
    @path = path
    @artist_pattern = options[:artist_pattern] || '*'
    @album_pattern  = options[:album_pattern] || '*'
    @song_pattern   = options[:song_pattern] || '*'
    @interactive    = options[:interactive] || false
  end
  
  def each_artist(&block)
    Dir.glob(File.join(@path, @artist_pattern)).each {|file| yield Artist.new(file)}
  end
  
  def traverse(&block)
    each_artist do |artist|
      next unless continue_with?(artist)
      yield artist
      artist.each_album(@album_pattern) do |album| 
        yield album
        album.each_song(@song_pattern) do |song|
          yield song
        end
      end
    end
  end

  def print
    traverse { |item| puts item }
  end
  
  def check
    traverse { |item| item.check }
  end
  
  def normalize
    traverse { |item| item.normalize }
  end
  
  private
  
  def continue_with?(obj)
    return true unless @interactive
    STDOUT.print ": "
    STDOUT.flush
    STDIN.readline =~ /y|yes/i
  end

end
