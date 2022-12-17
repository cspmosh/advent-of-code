class Sensor
  attr_reader :coordinates, :closest_beacon

  def initialize(coordinates: {}, closest_beacon:)
    @closest_beacon = closest_beacon
    @coordinates = coordinates
  end

  def x
    coordinates[:x]
  end

  def y
    coordinates[:y]
  end

  def distance_from_beacon
    (y - closest_beacon.y).abs + (x - closest_beacon.x).abs
  end

  def distance_from_coordinates(coordinates: {x:, y:})
    (y - coordinates[:y]).abs + (x - coordinates[:x]).abs
  end
end
