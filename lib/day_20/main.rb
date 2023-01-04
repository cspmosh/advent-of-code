encrypted_input = []
index = 0
debug = false

File.foreach('data/day_20/input.txt', chomp: true) do |line|
  encrypted_input << {value: line.to_i, original_index: index}
  index +=1
end

puts "Initial arrangement: \n#{encrypted_input.map { |n| n[:value] }}\n\n" if debug

0.upto(encrypted_input.size - 1) do |original_index|
  index = encrypted_input.index {|n| n[:original_index] == original_index }
  move_count = encrypted_input[index][:value]

  if move_count == 0
    puts "0 does not move:\n #{encrypted_input.map { |n| n[:value] }}\n\n" if debug
    next
  end

  new_index = (index + move_count) % (encrypted_input.size - 1)
  did_wrap_left = index + move_count <= 0
  did_wrap_right = index + move_count >= encrypted_input.size

  new_index = encrypted_input.size - 1 if new_index == 0 && did_wrap_left
  new_index = 0 if new_index == encrypted_input.size - 1 && did_wrap_right

  element = encrypted_input.delete_at(index)
  encrypted_input.insert(new_index, element)

  left_neighbor = encrypted_input[(new_index - 1) % encrypted_input.size][:value]
  right_neighbor = encrypted_input[(new_index + 1) % encrypted_input.size][:value]

  puts "#{element[:value]} moves between #{left_neighbor} and #{right_neighbor}:" if debug
  puts "#{encrypted_input.map { |n| n[:value] }}\n\n" if debug
end

grove_coordinate_1 = encrypted_input[(encrypted_input.index { |n| n[:value] == 0 } + 1000) % encrypted_input.size][:value]
grove_coordinate_2 = encrypted_input[(encrypted_input.index { |n| n[:value] == 0 } + 2000) % encrypted_input.size][:value]
grove_coordinate_3 = encrypted_input[(encrypted_input.index { |n| n[:value] == 0 } + 3000) % encrypted_input.size][:value]

puts "#{grove_coordinate_1 + grove_coordinate_2 + grove_coordinate_3}"
