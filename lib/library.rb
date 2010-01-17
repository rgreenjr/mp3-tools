class Library

  attr_accessor :path, :interactive, :artist_pattern, :album_pattern, :title_pattern
  
  def self.default(options={})
    if `hostname`.strip == 'whiskey.local'
      self.new('/Volumes/Media/iTunes Media/Music', options)
    else
      self.new('/Users/rgreen/Music/iTunes/iTunes Media/Music', options)
    end
  end

  def initialize(path, options={})
    @path = path
    @artist_pattern = options[:artist_pattern] || '*'
    @album_pattern  = options[:album_pattern]  || '*'
    @title_pattern  = options[:title_pattern]  || '*'
    @interactive    = options[:interactive]    || false
  end
  
  def each_artist(&block)
    Dir.glob(File.join(@path, @artist_pattern)).each {|file| yield Artist.new(file)}
  end
  
  def traverse(&block)
    each_artist do |artist|
      next unless continue_with?(artist)
      yield artist
      artist.each_album(@album_pattern) do |album| 
        yield album
        album.each_song(@title_pattern) do |song|
          yield song
        end
      end
    end
  end

  def print
    traverse { |item| puts item }
  end
  
  def check
    traverse { |item| item.check }
  end
  
  def normalize
    traverse { |item| item.normalize }
  end
  
  def dump
    each_name_entry { |name| puts name }
  end
  
  def spell
    each_name_entry do |name|
      misspelled = Dictionary.list_misspelled(name)
      Log.spelling_error(name, misspelled) unless misspelled.empty?
    end
    Log.save
  end
  
  private
  
  def continue_with?(obj)
    return true unless @interactive
    STDOUT.print ": "
    STDOUT.flush
    STDIN.readline =~ /y|yes/i
  end
  
  def each_name_entry
    File.open('/Users/rgreen/Music/iTunes/iTunes Music Library.xml', 'r') do |file|
      file.each do |line|
        if line =~ /<key>Name<\/key><string>(.*)<\/string>/i
          yield $1
        end
      end
    end
  end

end
