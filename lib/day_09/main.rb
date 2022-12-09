require_relative 'rope_bridge'

rope = RopeBridge.new(knot_count: 10)

File.foreach('data/d9_rope_movements.txt', chomp: true) do |line|
  rope.move_head(line)
end

puts "unique tail position count: #{rope.uniq_tail_positions_count}"
