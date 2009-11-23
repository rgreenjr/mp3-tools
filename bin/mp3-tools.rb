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
  :album_pattern  => '*',
  :artist_pattern => '*',
  :song_pattern   => '*',
  :interactive    => false,
  :action         => :print,
}

parser = OptionParser.new
parser.banner = "Usage: mp3-tools.rb [options]"
parser.on('-p', '--print', 'Print library contents') { options[:action] = :print }
parser.on('-c', '--check', 'Check library for missing metadata') { options[:action] = :check }
parser.on('-n', '--normalize', 'Normalize library songs') { options[:action] = :normalize }
parser.on('-a', '--artist_pattern [pattern]', String, 'Artist filtering pattern') { |pattern|  options[:artist_pattern] = pattern }
parser.on('-b', '--album_pattern [pattern]', 'Album filtering pattern') { |pattern| options[:album_pattern] = pattern }
parser.on('-s', '--song_pattern [pattern]', 'Song filtering pattern') { |pattern| options[:song_pattern] = pattern }
parser.on('-i', '--interactive', 'Request confirmation before processing an artist') { |flag| options[:interactive] = flag }
parser.on('-h', '--help', 'Display this screen') { puts parser; exit }
parser.parse!

Library.default(options).send(options[:action])
