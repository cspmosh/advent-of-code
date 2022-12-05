require "day_05/crate_mover_9001"

describe CrateMover9001 do
  describe ".move" do
    it "moves several crates at once" do
      stack_1 = ["A","B","C"]
      stack_2 = ["D","E","F"]

      CrateMover9001.move(quantity: 2, from_stack: stack_1, to_stack: stack_2)

      expect(stack_1).to eq(["A"])
      expect(stack_2).to eq(["D","E","F","B","C"])
    end
  end
end
