#!/usr/bin/env ruby -w
require "rubygems"
require 'mp3info'
require "lib/library"
require "lib/artist"
require "lib/album"
require "lib/song"
require 'lib/string'

def parse_args
  args = ARGV[0].to_s.split("/")
  if args.size != 3
    puts "Usage: #{$0} \"<albums>/<artists>/<songs>\""
    exit
  end
  args
end

library = Library.default
# library.interactive = true
library.print(*parse_args)
# library.list_missing_art(*parse_args)
# library.normalize_songs(*parse_args)
