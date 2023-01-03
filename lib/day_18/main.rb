require 'set'
require_relative 'lava_droplet'


coordinates = Set.new
droplet = LavaDroplet.new

File.foreach("data/day_18/input.txt", chomp: true) do |line|
  x, y, z = line.split(",").map(&:to_i)

  droplet.add_molecule(x:, y:, z:)
end

puts "total_untouched_sides #{droplet.surface_area}"
