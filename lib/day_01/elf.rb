class Elf
  include Comparable

  attr_reader :snacks

  def initialize(snacks: [])
    @snacks = snacks
  end

  def add_snack(calories)
    @snacks << calories
  end

  def total_calories
    snacks.sum
  end

  def <=>(other)
    total_calories <=> other.total_calories
  end
end
