require 'artist'

class Library

  attr_accessor :path
  
  def self.default
    if `hostname`.strip == 'bourbon.local'
      self.new("/Users/rgreen/Music/iTunes/iTunes Media/Music")
    else
      self.new("/Volumes/Media/iTunes Media/Music")
    end
  end

  def initialize(path)
    @path = path
  end

  def each_artist(pattern='', &block)
    Dir.glob(File.join(@path, "*#{pattern}*")).map {|file| yield Artist.new(file)}
  end

  def each_song(artist_pattern='', album_pattern='', song_pattern='', &block)
    each_artist(artist_pattern) do |artist|
      puts artist.name
      # next unless STDIN.readline =~ /y/
      artist.each_album(album_pattern) do |album| 
        puts "  " + album.name
        album.each_song(song_pattern) do |song|
          song.open do |mp3|
            yield song
          end
        end
      end
    end
  end

  def print_missing_art(artist_pattern='', album_pattern='', song_pattern='')
    each_song(artist_pattern, album_pattern, song_pattern) {|song| puts "    * missing art: #{song.path}" unless song.has_art? }
  end
  
  def normalize_songs(artist_pattern='', album_pattern='', song_pattern='')
    each_song(artist_pattern, album_pattern, song_pattern) {|song| song.normalize }
  end
  
  def print(artist_pattern='', album_pattern='', song_pattern='')
    each_song(artist_pattern, album_pattern, song_pattern) {|song| puts "    " + song.title }
  end

end
