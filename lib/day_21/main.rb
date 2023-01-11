require_relative 'job'
require_relative 'monkey_riddle'
require 'set'

monkeys = Set.new

File.foreach('data/day_21/input.txt', chomp: true) do |line|
  monkey, job = line.split(": ")

  monkeys.add({monkey: monkey, job: Job.new(job)})
end

riddle = MonkeyRiddle.new(monkeys:)

puts "answer: #{riddle.solve}"



