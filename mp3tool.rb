#!/usr/bin/env ruby -w
require 'rubygems'
require 'mp3info'
require 'optparse'

dir = File.expand_path(File.dirname(__FILE__))
Dir.glob("#{dir}/lib/*").each do |file| 
  require file
end

options = {
  :album_pattern  => '*',
  :artist_pattern => '*',
  :title_pattern  => '*',
  :interactive    => false,
  :action         => :print,
}

parser = OptionParser.new
parser.banner = "Usage: mp3-tools.rb [options]"
parser.on('-p', '--print', 'Print library contents') { options[:action] = :print }
parser.on('-c', '--check', 'Check library for missing metadata') { options[:action] = :check }
parser.on('-n', '--normalize', 'Normalize library songs') { options[:action] = :normalize }
parser.on('-d', '--dump', 'Dump library song titles') { options[:action] = :dump }
parser.on('-s', '--spell', 'Spell check song titles') { options[:action] = :spell }
parser.on('-a', '--artist_pattern [pattern]', String, 'Artist filtering pattern') { |pattern|  options[:artist_pattern] = pattern }
parser.on('-b', '--album_pattern [pattern]', 'Album filtering pattern') { |pattern| options[:album_pattern] = pattern }
parser.on('-t', '--title_pattern [pattern]', 'Song title filtering pattern') { |pattern| options[:title_pattern] = pattern }
parser.on('-i', '--interactive', 'Request confirmation before processing an artist') { |flag| options[:interactive] = flag }
parser.on('-h', '--help', 'Display this screen') { puts parser; exit }
parser.parse!

Library.default(options).send(options[:action])
