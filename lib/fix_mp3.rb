require "artist"
require "album"
require "song"

if `hostname`.strip == 'bourbon.local'
  ROOT = "/Users/rgreen/Music/iTunes/iTunes Media/Music"
else
  ROOT = "/Volumes/Media/iTunes Media/Music"
end

def show_usage
  puts "Usage: #{$0} \"<albums>/<artists>/<songs>\""
  exit
end

show_usage unless ARGV.size == 1
puts "ROOT = #{ROOT}"
p ARGV[0].split("/")
artist_pattern, album_pattern, song_pattern = ARGV[0].split("/")
show_usage unless artist_pattern || album_pattern || song_pattern

Artist.glob(ROOT, artist_pattern).each do |artist|
  puts artist.name
  # next unless STDIN.readline =~ /y/
  artist.each_album(album_pattern) do |album| 
    puts "  " + album.name
    album.each_song(song_pattern) do |song|
      song.open do |mp3|
        # puts "    " + song.title
        song.fix_album
      end
    end
  end
end
