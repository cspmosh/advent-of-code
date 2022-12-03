require "day_03/rucksack"

describe RuckSack do
  let(:items) { "vJrwpWtwJgWrhcsFMMfFFhFp" }

  describe "#find_dup" do
    it "returns the duplicate item in each rucksack" do
      rucksack = RuckSack.new(items: items)

      expect(rucksack.find_dup).to eq("p")
    end
  end

  describe "#find_unique_item" do
    it "returns the unique item from all provided rucksacks" do
      rucksack1 = RuckSack.new(items: "wMqvLMZHhHMvwLHjbvcjnnSBnvTQFn")
      rucksack2 = RuckSack.new(items: "ttgJtRGJQctTZtZT")
      rucksack3 = RuckSack.new(items: "CrZsJsPPZsGzwwsLwLmpwMDw")

      unique_item = RuckSack.find_unique_item(rucksacks: [rucksack1, rucksack2, rucksack3])

      expect(unique_item).to eq("Z")
    end
  end
end
