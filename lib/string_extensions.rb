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
    %w{A And As At By For From Of In On Or The To With}.inject(self) do |string, word| 
      string.gsub(/([^:;!\.-\/]) #{word} /) do |m|
        "#{$1} #{word.downcase} "
      end
    end
  end
  
  def romanize_movement_numbers
    self.sub(/: ([0-9]+)\. /) { |s| ": #{$1.to_roman}. " }
  end
  
  def canonicalize_key_signature
    # key, accidental, tonality
    self.sub(/ in ([A-G])(-sharp| sharp|-flat| flat)?( minor| major)?($|:|\.|,| |\/)/i) do |string|
      if $2 == nil && $3 == nil && $4 == ' ' # no accidental, no tonality, but a space indicating more to come
        string
      else
        " in #{$1.upcase}#{$2.downcase.tr('-', ' ') if $2}#{$3 ? $3.downcase : " major"}#{$4}"
      end
    end
  end

  def canonicalize_opus
    self.sub(/ Op( |\.|\. )?(\d+)($|:|,| |\/)/i) do |s|
      " Op. #{$2}#{$3}"
    end
  end
  
  def canonicalize_piece_number
    self.sub(/ No( |\.|\. )?(\d+)($|:|,| |\/)/i) do |s|
      " No. #{$2}#{$3}"
    end
  end
  
end
