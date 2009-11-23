#!/usr/bin/env ruby -w
require "rubygems"
require 'mp3info'
require 'optparse'
require "lib/library"
require "lib/artist"
require "lib/album"
require "lib/song"
require 'lib/string'

options = {
  :action         => :print,
  :album_pattern  => '*',
  :artist_pattern => '*',
  :song_pattern   => '*',
  :interactive    => false
}

parser = OptionParser.new

parser.banner = "Usage: mp3-tools.rb [options]"

parser.on('-p', '--print', 'Print library contents') do
  options[:action] = :print
end

parser.on('-c', '--check', 'Check library for missing metadata') do
  options[:action] = :check
end

parser.on('-n', '--normalize', 'Normalize library songs') do
  options[:action] = :normalize
end

parser.on('-a', '--artist_pattern [pattern]', String, 'Artist filtering pattern') do |pattern|
  options[:artist_pattern] = pattern
end

parser.on('-b', '--album_pattern [pattern]', 'Album filtering pattern') do |pattern|
  options[:album_pattern] = pattern
end

parser.on('-s', '--song_pattern [pattern]', 'Song filtering pattern') do |pattern|
  options[:song_pattern] = pattern
end

parser.on('-i', '--interactive', 'Request confirmation before processing an artist') do |flag|
  options[:interactive] = flag
end

parser.on('-h', '--help', 'Display this screen') do
  puts parser
  exit
end

parser.parse!

action = options.delete(:action)

Library.default(options).send(action)
