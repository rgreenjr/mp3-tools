class Library

  attr_accessor :path, :interactive
  
  def self.default
    if `hostname`.strip == 'whiskey.local'
      self.new("/Volumes/Media/iTunes Media/Music")
    else
      self.new("/Users/rgreen/Music/iTunes/iTunes Media/Music")
    end
  end

  def initialize(path, interactive=false)
    @path, @interactive = path, interactive
  end

  def each_artist(pattern='*', &block)
    Dir.glob(File.join(@path, pattern)).each {|file| yield Artist.new(file)}
  end

  def each_song(artist_pattern='*', album_pattern='*', song_pattern='*', &block)
    each_artist(artist_pattern) do |artist|
      next unless continue_with?(artist)
      artist.each_album(album_pattern) do |album| 
        puts album
        album.each_song(song_pattern) do |song|
          song.open do
            # @current = song
            yield song
          end
        end
      end
    end
  end

  def list_missing_art(artist_pattern='*', album_pattern='*', song_pattern='*')
    each_song(artist_pattern, album_pattern, song_pattern) {|song| puts "    * missing art: #{song.path}" unless song.has_art? }
  end
  
  def normalize_songs(artist_pattern='*', album_pattern='*', song_pattern='*')
    each_song(artist_pattern, album_pattern, song_pattern) {|song| song.normalize }
  end
  
  def print(artist_pattern='*', album_pattern='*', song_pattern='*')
    each_song(artist_pattern, album_pattern, song_pattern) {|song| puts song }
  end
  
  private
  
  def continue_with?(obj)
    if @interactive
      STDOUT.print "#{obj}: "
      STDOUT.flush
      STDIN.readline =~ /y|yes/i
    else
      puts obj
      return true
    end
  end

end
