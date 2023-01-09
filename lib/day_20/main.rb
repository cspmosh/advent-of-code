encrypted_input = []
index = 0
debug = true

File.foreach('data/day_20/input.txt', chomp: true) do |line|
  encrypted_input << {value: line.to_i, original_index: index}
  index +=1
end

decryption_key = 811589153
encrypted_input.each {|n| n[:value] = n[:value] * decryption_key }

puts "Initial arrangement: \n#{encrypted_input.map { |n| n[:value] }}\n\n" if debug

def mix_input(input)
  0.upto(input.size - 1) do |original_index|
    index = input.index {|n| n[:original_index] == original_index }
    move_count = input[index][:value]

    if move_count == 0
      # puts "0 does not move:\n#{input.map { |n| n[:value] }}\n\n"
      next
    end

    new_index = (index + move_count) % (input.size - 1)
    did_wrap_left = index + move_count <= 0
    did_wrap_right = index + move_count > input.size

    new_index = input.size - 1 if new_index == 0 && (did_wrap_left || did_wrap_right)
    # new_index = 0 if new_index == input.size - 1 && did_wrap_right

    element = input.delete_at(index)
    input.insert(new_index, element)

    left_neighbor = input[(new_index - 1) % input.size][:value]
    right_neighbor = input[(new_index + 1) % input.size][:value]

    # puts "#{element[:value]} moves between #{left_neighbor} and #{right_neighbor}:"
    # puts "#{input.map { |n| n[:value] }}\n\n"
  end

  input
end

10.times do |n|
  encrypted_input = mix_input(encrypted_input)

  puts "-------------------------------------"
  puts "after #{n + 1} round of mixing:"
  puts "#{encrypted_input.map { |n| n[:value] }}\n\n" if debug
end

grove_coordinate_1 = encrypted_input[(encrypted_input.index { |n| n[:value] == 0 } + 1000) % encrypted_input.size][:value]
grove_coordinate_2 = encrypted_input[(encrypted_input.index { |n| n[:value] == 0 } + 2000) % encrypted_input.size][:value]
grove_coordinate_3 = encrypted_input[(encrypted_input.index { |n| n[:value] == 0 } + 3000) % encrypted_input.size][:value]

puts "#{grove_coordinate_1 + grove_coordinate_2 + grove_coordinate_3}"
