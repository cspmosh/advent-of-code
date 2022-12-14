class Mountain
  attr_reader :locations, :starting_positions, :current_position, :destination_position

  def initialize
    @locations = []
    @starting_positions = []
    @current_position = nil
  end

  def add_locations(row)
    locations << row.split("")

    locations.last.each_with_index do |loc, index|
      @starting_positions << { x: index, y: locations.count - 1 } if loc == 'a' || loc == 'S'
    end

    @current_position = {x: row.index("S"), y: locations.count - 1} if !row.index("S").nil?
    @destination_position = {x: row.index("E"), y: locations.count - 1} if !row.index("E").nil?
  end

  def elevation(position)
    locations[position[:y]][position[:x]]
  end

  def visit_location(position)
    return unless valid_location?(position)

    @current_position = {x: position[:x], y: position[:y]}
  end

  def neighbors(position)
    northern_neighbor = {x: position[:x], y: position[:y] - 1}
    eastern_neighbor = {x: position[:x] + 1, y: position[:y] }
    southern_neighbor = {x: position[:x], y: position[:y] + 1 }
    western_neighbor = {x: position[:x] - 1, y: position[:y]}

    neighbors = [northern_neighbor, eastern_neighbor, southern_neighbor, western_neighbor]

    neighbors.select {|location| valid_location?(location)}
  end

  def elevation_value(elevation)
    return 'a'.ord if elevation == "S"
    return 'z'.ord if elevation == "E"

    elevation.ord
  end

  def climbable_neighbors(position)
    neighbors(position).select do |possible_location|
      elevation_value(elevation(possible_location)) <= elevation_value(elevation(position)) ||
      elevation_value(elevation(possible_location)) - elevation_value(elevation(position)) == 1
    end
  end

  def traverse(&block)
    locations.each do |row|
      row.each { |location| block.call(location) }
    end
  end

  def display
    locations.each do |row|
      row.each { |location| print location }
      print "\n"
    end
  end

private

  def valid_location?(position)
    return false if position[:y] < 0 or position[:y] > locations.count - 1
    return false if position[:x] < 0 or position[:x] > locations[position[:y]].count - 1

    true
  end
end
