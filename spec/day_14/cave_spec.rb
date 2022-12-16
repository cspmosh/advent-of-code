require 'day_14/cave'

describe Cave do
  let(:cave) { described_class.new }

  describe "#add_rocks" do
    it "adds rocks to cave" do
      cave.add_rocks("498,4 -> 498,6 -> 496,6")

      expect(cave.x_range_rocks).to include(498 => (4..6))
      expect(cave.y_range_rocks).to include(6 => (496..498))
    end
  end

  describe "#occupied_by_rock?" do
    it "returns true if something occupies the space" do
      cave.add_rocks("498,4 -> 498,6 -> 496,6")

      expect(cave.occupied_by_rock?(x: 498, y: 3)).to be false
      expect(cave.occupied_by_rock?(x: 498, y: 4)).to be true
      expect(cave.occupied_by_rock?(x: 498, y: 5)).to be true
      expect(cave.occupied_by_rock?(x: 498, y: 6)).to be true
      expect(cave.occupied_by_rock?(x: 498, y: 7)).to be false

      expect(cave.occupied_by_rock?(x: 499, y: 6)).to be false
      expect(cave.occupied_by_rock?(x: 498, y: 6)).to be true
      expect(cave.occupied_by_rock?(x: 497, y: 6)).to be true
      expect(cave.occupied_by_rock?(x: 496, y: 6)).to be true
      expect(cave.occupied_by_rock?(x: 495, y: 6)).to be false
    end
  end
end
