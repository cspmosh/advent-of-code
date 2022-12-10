class CRT
  attr_reader :sprite_position

  def initialize
    @sprite_position = (-1..1)
  end

  def draw_pixel(pixel)
    char = sprite_position.cover?(pixel) ? "#" : "."
    print "#{char}"
  end

  def move_sprite(value)
    @sprite_position = (value-1..value+1)
  end
end
