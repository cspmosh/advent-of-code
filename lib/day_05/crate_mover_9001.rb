class CrateMover9001
  class << self
    def move(quantity:, from_stack:, to_stack:)
      crates = from_stack.pop(quantity)
      to_stack.push(*crates)
    end
  end
end
