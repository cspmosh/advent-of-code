class Monkey
  attr_reader :id, :items, :operation, :divisibility_test, :test_true_monkey, :test_false_monkey

  def initialize(id:, starting_items:, operator:, operand:, divisibility_test:, test_true_monkey:, test_false_monkey:)
    @id = id
    @items = starting_items
    @operation = { operator: operator, operand: operand }
    @divisibility_test = divisibility_test
    @test_true_monkey = test_true_monkey
    @test_false_monkey = test_false_monkey
  end

  def inspect_next_item
    worry_level = items.shift
    puts "\tMonkey inspects an item with a worry level of #{worry_level}."

    worry_level
  end

  def determine_receiving_monkey_id(item)
    passes_divisibility_test = (item % divisibility_test).zero?
    puts "\t\tCurrent worry level is #{passes_divisibility_test ? "" : "not"} divisible by #{divisibility_test}"

    passes_divisibility_test ? test_true_monkey : test_false_monkey
  end

  def add_item(item)
    @items << item
  end

  def throw_item_to_monkey(item:, monkey:)
    monkey.add_item(item)
    puts "\t\tItem with worry level #{item} is thrown to monkey #{monkey.id}"
  end
end
