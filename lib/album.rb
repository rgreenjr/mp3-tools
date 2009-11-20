class Album
  
  attr_reader :path, :filename

  def initialize(path)
    @path, @filename = path, File.basename(path)
  end

  def each_song(song_pattern='*', &block)
    Dir.glob(File.join(escaped_path, "#{song_pattern}.mp3")).each {|file| yield Song.new(file)}
  end
  
  def check(song_pattern='*')
    puts self
    each_song(song_pattern) do |song|
      song.open do |song|
        puts "    * missing title:   #{song.filename}" unless song.has_title?
        puts "    * missing genre:   #{song.filename}" unless song.has_genre?
        puts "    * missing artwork: #{song.filename}" unless song.has_art?
      end
    end
  end
  
  def to_s
    "  #{@filename}"
  end
  
  def escaped_path
    @path.gsub(/\[/, '\[').gsub(/\]/, '\]')
  end
  
end
                          