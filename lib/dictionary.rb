require 'raspell'

class Dictionary
  
  # daren't
  # there'll
  # that'll
  # what'll
  # when's
  
  def self.dictionaries
    @dictionaries ||= %w{en es fr it de la grc ru}.map do |lang| 
      aspell = Aspell.new(lang)
      load_custom_words(aspell) if lang == 'en'
      aspell
    end
  end

  def self.list_misspelled(string)
    misspelled = [string]
    dictionaries.each do |dictionary|
      misspelled = dictionary.list_misspelled(misspelled)
      break if misspelled.empty?    
    end
    misspelled
  end
  
  private
  
  def self.load_custom_words(dictionary)
    File.open('./words.txt', 'r') do |file|
      file.each do |word|
        dictionary.add_to_session(word.strip)
        dictionary.add_to_session(word.capitalize.strip)
      end
    end
  end
    
end