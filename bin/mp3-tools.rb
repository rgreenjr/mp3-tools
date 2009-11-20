#!/usr/bin/env ruby -w
require "rubygems"
require 'mp3info'
require 'optparse'
require "lib/library"
require "lib/artist"
require "lib/album"
require "lib/song"
require 'lib/string'

options = {}
optparse = OptionParser.new do |opts|
  opts.banner = "Usage: mp3-tools.rb [options]"

  options[:print] = false
  opts.on( '-p', '--print', 'Print library contents') do
    options[:print] = true
  end

  options[:list_missing_art] = false
  opts.on( '-l', '--list_missing_art', 'Normalize library song titles') do
    options[:list_missing_art] = true
  end

  options[:normalize] = false
  opts.on( '-n', '--normalize', 'Normalize library song titles') do
    options[:normalize] = true
  end

  options[:artist_pattern] = '*'
  opts.on( '-a', '--artist_pattern [pattern]', String, 'Artist filtering pattern') do |pattern|
    options[:artist_pattern] = pattern
  end

  options[:album_pattern] = '*'
  opts.on( '-b', '--album_pattern [pattern]', 'Album filtering pattern') do |pattern|
    options[:album_pattern] = pattern
  end

  options[:song_pattern] = '*'
  opts.on( '-s', '--song_pattern [pattern]', 'Song filtering pattern') do |pattern|
    options[:song_pattern] = pattern
  end

  options[:interactive] = false
  opts.on( '-i', '--interactive', 'Request confirmation before processing an artist') do |pattern|
    options[:interactive] = pattern
  end

  opts.on('-h', '--help', 'Display this screen') do
    puts opts
    exit
  end
end
optparse.parse!

library = Library.default(options[:interactive])

patterns = [options[:artist_pattern], options[:album_pattern], options[:song_pattern]]

if options[:print] == true
  library.print(*patterns)
elsif options[:list_missing_art] == true
  library.list_missing_art(*patterns)
elsif options[:normalize] == true
  library.normalize_songs(*patterns)
else
  puts optparse
end
