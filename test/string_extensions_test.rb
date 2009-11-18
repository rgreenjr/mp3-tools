require 'test/unit'
require 'string_extensions.rb'

class StringExtensionTest < Test::Unit::TestCase
  
  def apply_all(string)
    string = string.remove_extraneous_spaces
    string = string.downcase_prepositions
    string = string.canonicalize_key_signature
    string = string.romanize_movement_numbers
    string = string.canonicalize_piece_number
    string = string.canonicalize_opus
  end
  
  def test_all
    assert_equal("2112: Overture/The Temples of Syrinx", apply_all("2112: Overture/The Temples of Syrinx"))
    assert_equal("Sleeping Beauty: The Panorama", apply_all("Sleeping Beauty: The Panorama"))
    assert_equal("Ballade No. 2 Op. 38 in F major", apply_all("Ballade No 2 Op 38 in F"))
    assert_equal("Ballade No. 2 in F major, Op. 38", apply_all("Ballade No 2 in F, Op 38"))
    assert_equal("Piano Concerto in A sharp minor: I. Allegro", apply_all("Piano Concerto In A-Sharp Minor: 1. Allegro"))
    assert_equal("Piano Concerto in A major", apply_all("Piano Concerto In A"))
    assert_equal("Piano Concerto in C sharp minor: II. Allegro", apply_all("Piano Concerto In c Sharp Minor: 2. Allegro"))
    assert_equal("Piano Concerto in E major: II. Allegro", apply_all("Piano Concerto In E: 2. Allegro"))
    assert_equal("Piano Concerto in A flat minor: IX. Allegro", apply_all("Piano Concerto In A-Flat Minor: 9. Allegro"))
    assert_equal("Piano Concerto in B flat minor: III. Allegro", apply_all("Piano Concerto In B Flat Minor: 3. Allegro"))
    assert_equal("Piano Concerto in A sharp major, K.32: V. Allegro", apply_all("Piano  Concerto In A-Sharp, K.32: 5. Allegro"))
    assert_equal("Piano Concerto in G sharp major: V. Allegro", apply_all("   Piano  Concerto In g-Sharp: 5. Allegro"))
    assert_equal("Piano Concerto in D flat major: V. Allegro", apply_all("Piano  Concerto In d flat:   5. Allegro  "))
    assert_equal("Piano Concerto in B flat major: V. Allegro", apply_all("Piano  Concerto In B-flat: 5. Allegro  "))
    assert_equal("Concerto No. 5 in B flat major, BWV 1051: II. Adagio ma non tanto", apply_all("Concerto No. 5 in B-flat, BWV 1051: II. Adagio ma non tanto"))
    assert_equal("The Musical Offering, BWV 1079: Fuga canonica in Epidiapente", apply_all("The Musical Offering, BWV 1079: Fuga canonica in Epidiapente"))
    assert_equal("Polonaise Op. 44 in F sharp minor", apply_all("Polonaise Op 44 in F sharp minor"))
    assert_equal("Piano Concerto in B major", apply_all("Piano  Concerto In B"))
    assert_equal("Keyboard Concerto No. 4 in A major, BWV1055: III. Allegro ma non tanto", apply_all("Keyboard Concerto No. 4 in A major, BWV1055: III. Allegro ma non tanto"))
    assert_equal("Fantasy in F minor/A flat major, Op. 49", apply_all("Fantasy in F minor/A flat major, Op. 49"))
    assert_equal("Billy the Kid (Ballet Suite): II. Street in a Frontier Town", apply_all("Billy the Kid (Ballet Suite): II. Street in A Frontier Town"))
    assert_equal("** Hark! The Herald Angels Sings/It Came upon a Midnight Clear", apply_all("** Hark! The Herald Angels Sings/It Came upon a Midnight Clear"))
    assert_equal("Concerto No. 7 in B flat major. I Capriccio", apply_all("Concerto No. 7 in B flat major. I Capriccio"))
    assert_equal("Sonata No. 3 in F minor Op. 5 - V. Finale: Allegro moderato ma rubato", apply_all("Sonata No.3 in F minor op.5 - V. Finale: Allegro moderato ma rubato"))
    assert_equal("V. The Little Shepherd", apply_all("V. The Little Shepherd"))
    # assert_equal("Fantasy in F minor/A flat major, Op. 49", apply_all("Fantasy in F minor/A flat, Op. 49"))
  end

  def test_canonicalize_opus
    assert_equal("Ballade No 2 Op. 38 in F", "Ballade No 2 Op 38 in F".canonicalize_opus)
    assert_equal("Ballade No 2 Op. 38 in F", "Ballade No 2 op. 38 in F".canonicalize_opus)
    assert_equal("Ballade No 2 in F, Op. 38", "Ballade No 2 in F, op. 38".canonicalize_opus)
    assert_equal("Ballade No. 2 in F, Op. 38", "Ballade No. 2 in F, Op 38".canonicalize_opus)
  end
  
  def test_canonicalize_piece_number
    assert_equal("Ballade No. 2 Op 38 in F", "Ballade No 2 Op 38 in F".canonicalize_piece_number)
    assert_equal("Ballade No. 2 Op 38 in F", "Ballade No. 2 Op 38 in F".canonicalize_piece_number)
    assert_equal("Ballade No. 2, Op. 38", "Ballade No 2, Op. 38".canonicalize_piece_number)
    assert_equal("Ballade No. 2", "Ballade No 2".canonicalize_piece_number)
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
