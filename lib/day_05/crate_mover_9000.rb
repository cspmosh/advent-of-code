class CrateMover9000
  class << self
    def move(quantity:, from_stack:, to_stack:)
      quantity.times do |n|
        crate = from_stack.pop
        to_stack.push(crate)
      end
    end
  end
end
