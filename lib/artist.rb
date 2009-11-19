require 'album'
require 'string_extensions'

class Artist

  attr_reader :path, :name

  def initialize(path)
    @path, @name = path, File.basename(path)
  end
  
  def each_album(pattern='', &block)
    Dir.glob(File.join(@path, "*#{pattern}*")).each {|file| yield Album.new(file)}
  end
  
end