require 'RMagick'

class Picture
  
  attr_accessor :text_encoding, :mime_type, :type, :description, :data
  
  def initialize(apic_tag)
    @text_encoding, @mime_type, @type, @description, @data = apic_tag.unpack("c Z* c Z* a*")
  end
  
  def image
    @image ||= Magick::Image.read_inline([@data].pack('m')).first
  end
  
  def width
    image.rows
  end
  
  def height
    image.columns
  end
  
  def undersized?
    (width < 600 && height < 600)
  end
  
  def to_s
    "#{width}x#{height}"
  end
  
end

