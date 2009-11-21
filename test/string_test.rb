require 'test/unit'
require 'string'

class StringExtensionTest < Test::Unit::TestCase
  
  def combine_all(string)
    string = string.remove_extraneous_spaces
    string = string.downcase_prepositions
    string = string.normalize_key_signature
    string = string.romanize_movement_numbers
    string = string.normalize_piece_number
    string = string.normalize_opus_number
  end
  
  def test_combining_all
    assert_equal("Ballade No. 2 Op. 38 in F major", combine_all("Ballade   No 2 Op 38 in F"))
    assert_equal("Ballade No. 2 in F major, Op. 38", combine_all("Ballade No 2 in F, Op 38 "))
    assert_equal("Piano Concerto in G sharp major: V. Allegro", combine_all("   Piano  Concerto In g-Sharp: 5. Allegro"))
    assert_equal("Piano Concerto in D flat major: VII. Allegro", combine_all("Piano  Concerto In d flat:   7. Allegro  "))
    assert_equal("Piano Concerto in B flat major: V. Allegro", combine_all("Piano  Concerto In B-flat: 5. Allegro  "))
    assert_equal("Concerto No. 5 in B flat major, BWV 1051: II. Adagio ma non tanto", combine_all("Concerto No. 5 in B-flat, BWV 1051: II. Adagio ma non tanto"))
    assert_equal("Polonaise Op. 44 in F sharp minor", combine_all("Polonaise Op 44 in F sharp minor"))
    assert_equal("Piano Concerto in B major", combine_all("Piano  Concerto In B"))
    assert_equal("Keyboard Concerto No. 4 in A major, BWV1055: III. Allegro ma non tanto", combine_all("Keyboard Concerto No. 4 in A major, BWV1055: III. Allegro ma non tanto"))
    assert_equal("Fantasy in F minor/A flat major, Op. 49", combine_all("Fantasy in F minor/A flat major, Op. 49"))
    assert_equal("Concerto No. 7 in B flat major. I Capriccio", combine_all("Concerto No. 7 in B flat major. I Capriccio"))
    assert_equal("Sonata No. 3 in F minor Op. 5 - V. Finale: Allegro moderato ma rubato", combine_all("Sonata No.3 in F minor op.5 - V. Finale: Allegro moderato ma rubato"))
    assert_equal("V. The Little Shepherd", combine_all("V. The Little Shepherd"))
  end
  
  def test_normalize_key_signature
    assert_equal("Piano Concerto in A sharp minor: I. Allegro", "Piano Concerto In A-Sharp Minor: I. Allegro".normalize_key_signature)
    assert_equal("Sonata in A major", "Sonata In A".normalize_key_signature)
    assert_equal("Piano Concerto in C sharp minor: II. Allegro", "Piano Concerto In c Sharp Minor: II. Allegro".normalize_key_signature)
    assert_equal("Concerto in E major: II. Allegro", "Concerto In E: II. Allegro".normalize_key_signature)
    assert_equal("Piano Concerto in A flat minor: 9. Allegro", "Piano Concerto In A-Flat Minor: 9. Allegro".normalize_key_signature)
    assert_equal("Piano Concerto in B flat minor: III. Allegro", "Piano Concerto In B Flat Minor: III. Allegro".normalize_key_signature)
    assert_equal("Piano Concerto in A sharp major, K.32: V. Allegro", "Piano Concerto In A-Sharp, K.32: V. Allegro".normalize_key_signature)
    assert_equal("The Musical Offering, BWV 1079: Fuga canonica in Epidiapente", "The Musical Offering, BWV 1079: Fuga canonica in Epidiapente".normalize_key_signature)
    assert_equal("He Was In A Major Rush", "He Was In A Major Rush".normalize_key_signature)
    assert_equal("She Was In A Minor Depression", "She Was In A Minor Depression".normalize_key_signature)
  end
  
  def test_downcase_prepositions
    assert_equal("Until the End", "Until The End".downcase_prepositions)
    assert_equal("From the Beginning", "From THE Beginning".downcase_prepositions)
    assert_equal("Moonshine: The Movie", "Moonshine: The Movie".downcase_prepositions)
    assert_equal("Rain - A Soundtrack for Meditation", "Rain - A Soundtrack For Meditation".downcase_prepositions)
    assert_equal("Hark! The Herald Angels Sings", "Hark! The Herald Angels Sings".downcase_prepositions)
    assert_equal("2112: Overture/The Temples of Syrinx", "2112: Overture/The Temples of Syrinx".downcase_prepositions)
    assert_equal("Billy the Kid (Ballet Suite): II. Street in a Frontier Town", "Billy the Kid (Ballet Suite): II. Street in A Frontier Town".downcase_prepositions)
  end

  def test_normalize_opus_number
    assert_equal("Ballade No 2 Op. 38 in F", "Ballade No 2 Op 38 in F".normalize_opus_number)
    assert_equal("Ballade No 2 Op. 38 in F", "Ballade No 2 op. 38 in F".normalize_opus_number)
    assert_equal("Ballade No 2 in F, Op. 38", "Ballade No 2 in F, op. 38".normalize_opus_number)
    assert_equal("Ballade No. 2 in F, Op. 38", "Ballade No. 2 in F, Op 38".normalize_opus_number)
  end
  
  def test_normalize_piece_number
    assert_equal("Ballade No. 2 Op 38 in F", "Ballade No 2 Op 38 in F".normalize_piece_number)
    assert_equal("Ballade No. 2 Op 38 in F", "Ballade No. 2 Op 38 in F".normalize_piece_number)
    assert_equal("Ballade No. 2, Op. 38", "Ballade No 2, Op. 38".normalize_piece_number)
    assert_equal("Ballade No. 2", "Ballade No 2".normalize_piece_number)
  end
  
  def test_remove_extraneous_spaces
    assert_equal("The Continuing Story of Bungalow Bill", "    The   Continuing Story      of Bungalow Bill    ".remove_extraneous_spaces)
    assert_equal("Rip It Up/Shake Rattle and Roll/Blue Suede Shoes", "Rip It Up / Shake Rattle and Roll / Blue Suede Shoes".remove_extraneous_spaces)
  end

  def test_to_roman
    assert_equal("I",    "1".to_roman)
    assert_equal("II",   "2".to_roman)
    assert_equal("III",  "3".to_roman)
    assert_equal("IV",   "4".to_roman)
    assert_equal("V",    "5".to_roman)
    assert_equal("X",   "10".to_roman)
    assert_equal("XV",  "15".to_roman)
    assert_equal("XX",  "20".to_roman)
    assert_equal("XXI", "21".to_roman)
    assert_equal("XXX", "30".to_roman)
  end
  
end
