class Location
  include Comparable
  attr_reader :x, :y, :elevation, :previous_location, :neighbors

  def initialize(x: , y:, elevation:, previous_location: nil)
    @x = x
    @y = y
    @elevation = elevation
    @previous_location = previous_location
  end

  def add_neighbors
    @neighbors
  end

  def ==(other)
    x == other&.x && y == other&.y
  end
end
