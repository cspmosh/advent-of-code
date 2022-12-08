require_relative "rucksack"
require_relative "prioritizer"

total_priorities = 0
total_priority_of_unique_items = 0
elf_group = []

DirFile.foreach("data/d3_rucksack_contents.txt", chomp: true) do |items|
  rucksack = RuckSack.new(items: items)
  total_priorities += Prioritizer.call(rucksack.find_dup)

  elf_group << rucksack

  if elf_group.size == 3
    unique_item = RuckSack.find_unique_item(rucksacks: elf_group)
    total_priority_of_unique_items += Prioritizer.call(unique_item)

    elf_group.clear
  end
end

puts "total priorities: " + total_priorities.to_s
puts "toal priority of unique group items: " + total_priority_of_unique_items.to_s
