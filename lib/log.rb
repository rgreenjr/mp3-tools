class Log
  
  @entries = {}
  
  def self.print(msg)
    puts "      * #{msg}"
  end
  
  def self.album_error(album, msg)
    @entries[album] = msg
  end
  
  def self.song_error(song, msg)
    @entries[song] = msg
  end
  
  def self.picture_error(artist, album)
    album_error(album, "<p>#{albumartexchange_link(artist, album)}&nbsp;&nbsp;&nbsp;&nbsp;#{google_image_link(artist, album)}</p>")
  end
  
  def self.spelling_error(title, misspelled)
    # msg = "<p>#{google_link(title)}"
    # misspelled.each { |word| msg << "&nbsp;&nbsp;#{google_link(word)}" }
    # msg << "</p>"
    # @entries[title] = msg
    misspelled.each { |e| puts e }
  end
  
  def self.save
    File.open("/Users/rgreen/Desktop/mp3-tools.html", "w") do |file|
      file.write("<!DOCTYPE html>\n<html lang='en'>\n<head>\n<meta charset='utf-8'/>\n<title>mp3-tools</title>\n<body>\n")
      @entries.values.sort.each { |msg| file.write(msg + "\n") }
      file.write("</body>\n</html>\n")
    end
  end
  
  private

  def self.google_link(*args)
    "<a href='http://www.google.com/search?client=safari&rls=en&ie=UTF-8&oe=UTF-8&q=#{url_encode(args)}'>#{args.join(' ')}</a>"
  end
  
  def self.google_image_link(*args)
    "<a href='http://images.google.com/images?q=#{url_encode(args)}'>#{args.join(' ')}</a>"
  end
  
  def self.albumartexchange_link(*args)
    "<a href='http://www.albumartexchange.com/covers.php?sort=1&fltr=1&q=#{url_encode(args)}'>#{args.join(' ')}</a>"
  end
  
  def self.url_encode(args)
    args.map{|a| CGI::escape(a)}.join('+')
  end
  
end

