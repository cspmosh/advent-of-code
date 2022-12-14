require_relative '../day_12/mountain'
require_relative '../day_12/location'

mountain = Mountain.new

File.foreach('data/d12_input.txt', chomp: true) do |line|
  mountain.add_locations(line)
end

mountain.display
puts ""

# def climb_mountain(mountain:)
#   next_locations = [mountain.current_position]
#   visited = [mountain.current_position]
#   remaining_location_count = 1
#   next_location_count = 0
#   steps = 0
#   reached_end = false
#   path = []
#   location = nil
#
#   until next_locations.size == 0
#     previous_location = location if !location.nil?
#     location = next_locations.shift
#
#     path << Location.new(x: location[:x], y: location[:y], elevation: mountain.elevation(location), previous_location:)
#
#     if mountain.elevation(location) == "E"
#       reached_end = true
#       break
#     end
#
#     neighbors = (mountain.climbable_neighbors(location) - visited.flatten)
#     visited << neighbors
#     next_locations += neighbors
#     next_location_count = neighbors.count
#
#     remaining_location_count -= 1
#
#     if remaining_location_count == 0
#       remaining_location_count = next_location_count
#       next_location_count = 0
#     end
#   end
#
#   if reached_end
#     puts "path: #{path.last.previous_location}"
#     return steps
#   end
#
#   return -1
# end

def climb_mountain(mountain:, starting_position: nil)
  current_pos = starting_position.nil? ? mountain.current_position : starting_position
  location = Location.new(x: current_pos[:x], y: current_pos[:y], elevation: mountain.elevation(current_pos))
  next_locations = [location]
  visited_positions = [{ x: location.x, y: location.y }]

  until next_locations.size == 0
    location = next_locations.shift

    if location.elevation == "E"
      return location
    end

    climbable_neighbors = mountain.climbable_neighbors(
      {x: location.x, y: location.y}
    ) - visited_positions

    neighbors = climbable_neighbors.map{|neighbor| Location.new(
      x: neighbor[:x],
      y: neighbor[:y],
      elevation: mountain.elevation(neighbor),
      previous_location: location)}

    next_locations += neighbors
    visited_positions += climbable_neighbors
  end

  return nil
end

fewest_steps = 10_000

mountain.starting_positions.each do |starting_position|
  count = 0
  destination = climb_mountain(mountain:, starting_position:)
  location = destination

  until location&.previous_location == nil
    count += 1
    print "#{location.elevation}<--"
    location = location&.previous_location
    print "S \tcount: #{count}\n\n" if location&.previous_location.nil?
  end


  fewest_steps = count if count < fewest_steps && !location.nil?
end

puts "\n\nfewest steps: #{fewest_steps}"


