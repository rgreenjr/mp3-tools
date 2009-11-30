require 'RMagick'

class Picture
  
  attr_accessor :text_encoding, :mime_type, :type, :description, :data
  
  def initialize(apic)
    apic = apic.first if apic.class == Array
    @text_encoding, @mime_type, @type, @description, @data = apic.unpack("c Z* c Z* a*")
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
  
  def undersized?(pixels=600)
    (width < pixels && height < pixels)
  end
  
  def to_s
    "#{width}x#{height}"
  end
  
end

