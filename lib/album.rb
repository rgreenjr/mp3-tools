require 'song'
require 'string_extensions'

class Album
  
  attr_reader :path, :name

  def initialize(path)
    @path, @name = path, File.basename(path)
  end

  def each_song(pattern='', &block)
    Dir.glob(File.join(@path, "*#{pattern}*.mp3")).each {|file| yield Song.new(file)}
  end
  
end
                          