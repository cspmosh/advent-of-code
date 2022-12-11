require_relative 'monkey'

monkeys = []
starting_items = []
monkey_id = nil
operator = nil
operand = nil
divisibility_test = nil
test_true_monkey = nil
test_false_monkey = nil

def increase_worry_level(worry_level, monkey, common_divisor)
  new_worry_level = worry_level
  operand = monkey.operation[:operand].to_s == "old" ? worry_level : monkey.operation[:operand]

  case monkey.operation[:operator]
  when "+"
    new_worry_level += operand
    puts "\t\tWorry level increases by #{operand == worry_level ? "itself" : operand.to_s} to #{new_worry_level}."
  when "*"
    new_worry_level *= operand
    puts "\t\tWorry level is multiplied by #{operand == worry_level ? "itself" : operand.to_s} to #{new_worry_level}."
  end

  # Part 1
  # current_worry_level /= 3
  # puts "\t\tMonkey gets bored with item. Worry level is divided by 3 to #{current_worry_level}."

  new_worry_level % common_divisor
end

File.foreach('data/d11_input.txt', chomp: true) do |line|
  if line.empty?
    monkey = Monkey.new(id: monkey_id, starting_items: starting_items.map {|i| i}, operator:, operand:, divisibility_test:, test_true_monkey:, test_false_monkey:)
    monkeys << monkey
    starting_items.clear

    next
  end

  property, value = line.split(":").map(&:strip)
  property_elements = property.split

  case property_elements[0]
  when "Monkey"
    monkey_id = property_elements[1].to_i
  when "Starting"
    value.split(",").each {|item| starting_items << item.strip.to_i }
  when "Operation"
    _p, _p2, _p3, operator, operand = value.split
    if operand != "old"
      operand = operand.to_i
    end
  when "Test"
    _p, _p2, divisibility_test = value.split
    divisibility_test = divisibility_test.to_i
  when "If"
    if property_elements[1] == "true"
      _p, _p2, _p3, test_true_monkey = value.split
      test_true_monkey = test_true_monkey.to_i
    else
      _p, _p2, _p3, test_false_monkey = value.split
      test_false_monkey = test_false_monkey.to_i
    end
  end
end

monkey = Monkey.new(
  id: monkey_id,
  starting_items: starting_items.map {|i| i},
  operator:,
  operand:,
  divisibility_test:,
  test_true_monkey:,
  test_false_monkey:)

monkeys << monkey

common_divisor = monkeys.map(&:divisibility_test).inject(:*)

items_inspected = []

1.upto(10_000) do |round|
  monkeys.each do |monkey|
    puts "Monkey #{monkey.id}:\n"

    if items_inspected[monkey.id].nil?
      items_inspected << monkey.items.count
    else
      items_inspected[monkey.id] += monkey.items.count
    end

    until monkey.items.empty?
      item = monkey.inspect_next_item
      item = increase_worry_level(item, monkey, common_divisor)
      receiving_monkey = monkeys[monkey.determine_receiving_monkey_id(item)]
      monkey.throw_item_to_monkey(item: item, monkey: receiving_monkey)
    end
  end
end

top_two = items_inspected.max(2)
puts "\n"
puts "monkey business: #{top_two[0] * top_two[1]}"
