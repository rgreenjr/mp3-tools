require 'raspell'

class Dictionary
  
  def self.dictionaries
    @dictionaries ||= %w{en es fr it de la grc ru}.map do |lang| 
      aspell = Aspell.new(lang)
      if lang == 'en'
        File.open('words.txt', 'r') do |file|
          file.each do |word|
            word.strip!
            aspell.add_to_session(word)
            aspell.add_to_session(word.capitalize)
          end
        end
      end
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
  
end