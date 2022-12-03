require "day_03/prioritizer"

describe Prioritizer do
  describe ".call" do
    it "prioritizes the item" do
      priority = described_class.call("p")
      priority_2 = described_class.call("L")

      expect(priority).to eq(16)
      expect(priority_2).to eq(38)
    end
  end
end
