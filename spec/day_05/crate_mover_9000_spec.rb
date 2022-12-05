require 'day_05/crate_mover_9000'

describe CrateMover9000 do
  describe ".move" do
    it "moves one crate at a time" do
      stack_1 = ["A","B","C"]
      stack_2 = ["D","E","F"]

      CrateMover9000.move(quantity: 2, from_stack: stack_1, to_stack: stack_2)

      expect(stack_1).to eq(["A"])
      expect(stack_2).to eq(["D","E","F","C","B"])
    end
  end
end
