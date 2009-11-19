class String
  
  ROMAN_MAP = {
    1    => "I",
    4    => "IV",
    5    => "V",
    9    => "IX",
    10   => "X",
    40   => "XL",
    50   => "L",
    90   => "XC",
    100  => "C",
    400  => "CD",
    500  => "D",
    900  => "CM",
    1000 => "M"
  }

  ROMAN_NUMERALS = [""] + Array.new(3999) do |index|
    target = index + 1
    ROMAN_MAP.keys.sort { |a, b| b <=> a }.inject("") do |roman, div|
      times, target = target.divmod(div)
      roman << ROMAN_MAP[div] * times
    end
  end
  
  def to_roman
    ROMAN_NUMERALS[self.to_i]
  end

  def remove_extraneous_spaces
    self.strip.squeeze(' ')
  end

  def downcase_prepositions
    %w{a and as at by for from of in on or the to with}.inject(self) do |string, word| 
      string.gsub(/(\w) #{word} /i) do |m|
        "#{$1} #{word.downcase} "
      end
    end
  end
  
  def romanize_movement_numbers
    self.sub(/: ([0-9]+)\. /) { |s| ": #{$1.to_roman}. " }
  end

  # Normalizes the key, accidental and tonality
  def normalize_key_signature
    return self if self =~ / in (a)( minor| major)( \w)/i # handle phrases such as 'He was in a major rush'
    self.sub(/ in ([A-G])(-sharp| sharp|-flat| flat)?( minor| major)?($| |\W)/i) do |string|
      " in #{$1.upcase}#{$2.downcase.tr('-', ' ') if $2}#{$3 ? $3.downcase : " major"}#{$4}"
    end
  end

  def normalize_opus_number
    self.sub(/ Op( |\.|\. )?(\d+)($| |\W)/i) do |s|
      " Op. #{$2}#{$3}"
    end
  end
  
  def normalize_piece_number
    self.sub(/ No( |\.|\. )?(\d+)($| |\W)/i) do |s|
      " No. #{$2}#{$3}"
    end
  end
  
end
