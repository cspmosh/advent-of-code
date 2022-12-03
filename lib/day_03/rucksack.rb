class RuckSack
  attr_reader :items, :compartment_1, :compartment_2

  def self.find_unique_item(rucksacks: [])
    return nil if rucksacks.empty?

    first_rucksack = rucksacks[0]
    other_rucksacks = rucksacks[1, rucksacks.length - 1]

    first_rucksack.items.split("").each do |item|
      return item if other_rucksacks.all? {|rucksack| rucksack.items =~ /#{item}/ }
    end

    nil
  end

  def initialize(items: "")
    @items = items
    @compartment_1, @compartment_2 = half(items)
  end

  def find_dup
    compartment_1.match(/[#{compartment_2}]/)[0]
  end

private

  def half(str)
    str.partition(/.{#{str.size/2}}/)[1,2]
  end
end
