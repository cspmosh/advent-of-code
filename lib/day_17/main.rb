require_relative 'cavern'
require_relative 'rock_queue'
require_relative 'jet_queue'

rock_queue = RockQueue.new
jet_queue = JetQueue.new(file: "data/day_17/input.txt")
cavern = Cavern.new(rock_queue:, display_on: false)

rocks_dropped = 0

while rocks_dropped < 1_000_000_000_000
  cavern.spawn_new_rock

  until cavern.falling_rock_at_rest?
    jet = jet_queue.next

    case jet
    when "<"
      cavern.move_rock_left
    when ">"
      cavern.move_rock_right
    end
  end

  rocks_dropped += 1
end

puts "tower height: #{cavern.height}"

