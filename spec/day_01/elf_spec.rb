require "day_01/elf"

describe Elf do
  let(:elf) { Elf.new(food_items: [10, 2000, 300]) }

  describe "#food_items" do
    it "returns an array of calories" do
      expect(elf.food_items).to eq([10, 2000, 300])
    end
  end

  describe "#total_calories" do
    it "returns the total calories of all the food items" do
      expect(elf.total_calories).to eq(2310)
    end
  end
end
