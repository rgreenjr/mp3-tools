#!/usr/bin/env ruby -w
require "rubygems"
require 'mp3info'
require "lib/library"
require "lib/artist"
require "lib/album"
require "lib/song"
require 'lib/string'

def usage
  puts "Usage: #{$0} \"<albums>/<artists>/<songs>\""
  exit
end

def parse_args
  args = ARGV[0].to_s.split("/")
  usage unless args.size == 3
  args
end

library = Library.default
library.print(*parse_args)
# library.print_missing_art(*parse_args)
# library.normalize_songs(*parse_args)
