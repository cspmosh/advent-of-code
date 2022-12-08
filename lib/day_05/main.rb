require_relative 'crate_mover_9000'
require_relative 'crate_mover_9001'

crates = []
secret_message = ""

DirFile.foreach("data/d5_crate_stacks.txt", chomp: true) do |line|
  stack = line.split(",")
  crates << stack
end

DirFile.foreach("data/d5_crate_moving_instructions.txt", chomp: true) do |line|
  instructions = line.split(" ")
  quantity = instructions[1].to_i
  from_stack = instructions[3].to_i - 1
  to_stack = instructions[5].to_i - 1

  # CrateMover9000.move(quantity: quantity, from_stack: crates[from_stack], to_stack: crates[to_stack])
  CrateMover9001.move(quantity: quantity, from_stack: crates[from_stack], to_stack: crates[to_stack])
end

crates.each do |n|
  secret_message += n.last
end

puts secret_message
