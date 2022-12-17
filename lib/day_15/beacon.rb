class Beacon
  attr_reader :coordinates

  def initialize(coordinates: {})
    @coordinates = coordinates
  end

  def x
    coordinates[:x]
  end

  def y
    coordinates[:y]
  end
end
