require_relative 'beacon'
require_relative 'sensor'

sensors = []

File.foreach('data/day_15/input.txt', chomp: true) do |line|
  sensor_data, beacon_data = line.split(":")
  sensor_coordinate_data = sensor_data.split(" at ")[1]
  beacon_coordinate_data = beacon_data.split(" at ")[1]

  sensor_coordinates = sensor_coordinate_data.split(", ").map{ |axis| axis.split("=")[1] }
  beacon_coordinates = beacon_coordinate_data.split(", ").map{ |axis| axis.split("=")[1] }

  beacon = Beacon.new(coordinates: { x: beacon_coordinates[0].to_i, y: beacon_coordinates[1].to_i })
  sensors << Sensor.new(coordinates: { x: sensor_coordinates[0].to_i, y: sensor_coordinates[1].to_i }, closest_beacon: beacon)
end

# PART 1
# y = 2000000
# positions_with_no_beacons = []
#
# sensors.each do |sensor|
#   distance_from_y = (sensor.y - y).abs
#
#   next if distance_from_y > sensor.distance_from_beacon
#
#   # puts "sensor: #{sensor}, coordinates: #{sensor.coordinates}, distance_from_y: #{distance_from_y}, distance_from_beacon: #{sensor.distance_from_beacon}"
#
#   positions_with_no_beacons << {x: sensor.x, y:}
#
#   1.upto(sensor.distance_from_beacon - distance_from_y).each do |n|
#     positions_with_no_beacons << {x: sensor.x + n, y:}
#     positions_with_no_beacons << {x: sensor.x - n, y:}
#   end
# end

# positions_with_no_beacons -= sensors.map(&:coordinates)
# positions_with_no_beacons -= sensors.map(&:closest_beacon).map(&:coordinates)
#
# puts positions_with_no_beacons.uniq.count


ordered_sensors = sensors.sort_by{|sensor| sensor.y }
distress_beacon_coordinates = {}

#PART 2
0.upto(4_000_000) do |y|
  x = 0

  while x <= 4_000_000
    #find the first sensor that has range to reach this x,y
    first_sensor_in_range = ordered_sensors.find {|s| s.distance_from_coordinates(coordinates: {x:, y:}) <= s.distance_from_beacon }

    if first_sensor_in_range.nil?
      #FOUND THE DISTRESS BEACON!
      distress_beacon_coordinates = {x:, y:}
      break
    end

    distance_from_y = (first_sensor_in_range.y - y).abs
    max_x_distance = first_sensor_in_range.distance_from_beacon - distance_from_y
    x = first_sensor_in_range.x + max_x_distance + 1
  end

  break if !distress_beacon_coordinates.empty?
end

puts "distress_beacon_coordinates: #{distress_beacon_coordinates}"
puts "tuning_frequency: #{distress_beacon_coordinates[:x] * 4_000_000 + distress_beacon_coordinates[:y]}"
