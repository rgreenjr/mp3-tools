require 'library'
require 'artist'
require 'album'
require 'song'

def usage
  puts "Usage: #{$0} \"<albums>/<artists>/<songs>\""
  exit
end

def parse_args
  usage unless ARGV.size == 1
  args = ARGV[0].split("/")
  usage unless args.size == 3
  args
end


# Library.default.print(*parse_args)
# Library.default.print_missing_art(*parse_args)
Library.default.normalize_songs(*parse_args)
