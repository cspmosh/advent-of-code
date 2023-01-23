require_relative 'job'
require_relative 'monkey_riddle'

monkeys = Hash.new

File.foreach('data/day_21/input.txt', chomp: true) do |line|
  monkey, job = line.split(": ")

  monkeys.merge!(monkey => job)
end

riddle = MonkeyRiddle.new(monkeys:)
puts "answer: #{riddle.solve}"

monkeys.merge!("root" => monkeys["root"].gsub("+", "=="))
monkeys.merge!("humn" => "X")

riddle = MonkeyRiddle.new(monkeys:)

puts "answer: #{riddle.solve_for_x}"  #Not 8401064794714

