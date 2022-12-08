require_relative 'elf_finder'

elf = Elf.new
elfs = []

File.foreach("data/d1_elf_snacks.txt", chomp: true) do |calories|
  if calories.empty?
    elfs << elf
    elf = Elf.new
    next
  end

  elf.add_snack(calories.to_i)
end

elfs << elf

finder = ElfFinder.new(elfs: elfs)

puts finder.top_caloric_elfs(3).sum { |elf| elf.total_calories }

