require_relative "elf"

class ElfFinder
  attr_reader :elfs

  def initialize(elfs:)
    @elfs = elfs
  end

  def top_caloric_elfs(n = 1)
    elfs.max(n) { |a, b| a <=> b }
  end
end
