require_relative 'cave'

cave = Cave.new

File.foreach("data/d14_input.txt", chomp: true) do |line|
  cave.add_rocks(line)
end

#part 2 - the floor
cave.add_rock_floor

# cave.display

result = cave.drop_sand(cave.sand_source[:x], cave.sand_source[:y])

while result != -1
  result = cave.drop_sand(cave.sand_source[:x], cave.sand_source[:y])
end

puts "units of sand: #{cave.sand_locations.count}"
