class Tag

  ADMIT = [
    'APIC', # Attached picture
    'COMM', # Comments
    'TALB', # Album/Movie/Show title
    'TCOM', # Composer
    'TCON', # Content type
    'TDRC', # Recording time
    'TFLT', # File type
    'TIT1', # Content group description
    'TIT2', # Title/songname/content description
    'TIT3', # Subtitle/Description refinement
    'TOPE', # Original artist(s)/performer(s)
    'TPOS', # Part of a set
    'TPE1', # Lead performer(s)/Soloist(s)
    'TPE2', # Band/orchestra/accompaniment
    'TPE3', # Conductor/performer refinement
    'TPE4', # Interpreted, remixed, or otherwise modified by
    'TPUB', # Publisher
    'TRCK', # Track number/Position in set
    'USLT', # Unsynchronised lyric/text transcription

    'TCMP', # iTunes's compilation flag
    'TYER', #
    'disc_number', #
    'disc_total', #

    'AENC', # Audio encryption
    'ASPI', # Audio seek point index
    'COMR', # Commercial frame
    'ENCR', # Encryption method registration
    'EQU2', # Equalisation
    'ETCO', # Event timing codes
    'GRID', # Group identification registration
    'OWNE', # Ownership frame
    'RBUF', # Recommended buffer size
    'SEEK', # Seek frame
    'SIGN', # Signature frame
    'SYLT', # Synchronised lyric/text
    'SYTC', # Synchronised tempo codes
    'TEXT', # Lyricist/Text writer
    'TSOA', # Album sort order
    'TSOP', # Performer sort order
    'TSOT', # Title sort order
    'TSST', # Set subtitle
  ]
  
  REJECT = [
    'COMM', # Comments
    'GEOB', # General encapsulated object
    'LINK', # Linked information
    'MCDI', # Music CD identifier
    'MLLT', # MPEG location lookup table
    'NCON', #
    'PRIV', # Private frame
    'PCNT', # Play counter
    'POPM', # Popularimeter
    'POSS', # Position synchronisation frame
    'RVA2', # Relative volume adjustment
    'RVRB', # Reverb
    'RVAD', #
    'TBPM', # BPM (beats per minute)
    'TCOP', # Copyright message
    'TDEN', # Encoding time
    'TDLY', # Playlist delay
    'TDOR', # Original release time
    'TDRL', # Release time
    'TDTG', # Tagging time
    'TENC', # Encoded by
    'TIPL', # Involved people list
    'TKEY', # Initial key
    'TLAN', # Language(s)
    'TLEN', # Length
    'TMCL', # Musician credits list
    'TMED', # Media type
    'TMOO', # Mood
    'TOAL', # Original album/movie/show title
    'TOFN', # Original filename
    'TOLY', # Original lyricist(s)/text writer(s)
    'TOWN', # File owner/licensee
    'TPRO', # Produced notice
    'TRSN', # Internet radio station name
    'TRSO', # Internet radio station owner
    'TSRC', # ISRC (international standard recording code)
    'TSSE', # Software/Hardware and settings used for encoding
    'TXXX', # User defined text information frame
    'UFID', # Unique file identifier
    'USER', # Terms of use
    'WCOM', # Commercial information
    'WCOP', # Copyright/Legal information
    'WOAF', # Official audio file webpage
    'WOAR', # Official artist/performer webpage
    'WOAS', # Official audio source webpage
    'WORS', # Official Internet radio station homepage
    'WPAY', # Payment
    'WPUB', # Publishers official webpage
    'WXXX', # User defined URL link frame
    
    'XDOR', # MusicBrainz’ TDOR equivalent
    'XSOP', # MusicBrainz’ TSOP equivalent
    'RGAD', # Replay Gain Adjustment
    'TSIZ', # Size
    'TDAT',
    "TCP\000",
    "CM1\000",
    'TSP ',
  ]

  def self.admit?(tag)
    ADMIT.include?(tag)
  end

  def self.reject?(tag)
    REJECT.include?(tag)
  end

  def self.known?(tag)
    admit?(tag) || reject?(tag)
  end

end