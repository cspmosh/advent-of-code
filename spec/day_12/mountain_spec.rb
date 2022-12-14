require "day_12/mountain"
require 'pry'

describe Mountain do
  let(:mountain) { described_class.new }

  describe "#add_locations" do
    it "adds locations to the mountain" do
      mountain.add_locations("SabE")

      expect(mountain.locations[0]).to include("S","a","b","E")
    end
  end

  describe "#current_location" do
    before do
      mountain.add_locations("abcde")
      mountain.add_locations("fgSij")
    end

    it "returns the current position on the mountain" do
      expect(mountain.current_position).to eq({x: 2, y: 1})
    end
  end

  describe "#destination_location" do
    before do
      mountain.add_locations("abcde")
      mountain.add_locations("fgEij")
    end

    it "returns the destination position on the mountain" do
      expect(mountain.destination_position).to eq({x: 2, y: 1})
    end
  end

  describe "#elevation" do
    before do
      mountain.add_locations("abcde")
      mountain.add_locations("fgSij")
    end

    it "returns the elevation of the given position" do
      expect(mountain.elevation({x: 2, y: 1})).to eq("S")
      expect(mountain.elevation({x: 0, y: 0})).to eq("a")
    end
  end

  describe "#visit_location" do
    before do
      mountain.add_locations("abcde")
      mountain.add_locations("fgSij")
    end

    context "when the location is valid" do
      it "visits the location on the mountain" do
        mountain.visit_location({x: 3, y: 0})

        expect(mountain.current_position).to eq({x: 3, y: 0})
      end
    end

    context "when the location is not valid" do
      it "does not set the current position" do
        mountain.visit_location({x: -1, y: 0})
        expect(mountain.current_position).to_not eq({x: -1, y: 0})

        mountain.visit_location({x: 5, y: 0})
        expect(mountain.current_position).to_not eq({x: 5, y: 0})

        mountain.visit_location({x: 0, y: -1})
        expect(mountain.current_position).to_not eq({x: 0, y: -1})

        mountain.visit_location({x: 0, y: 2})
        expect(mountain.current_position).to_not eq({x: 0, y: 2})
      end
    end
  end

  describe "#neighbors" do
    before do
      mountain.add_locations("abc")
      mountain.add_locations("fgS")
      mountain.add_locations("ghi")
    end

    it "returns a given location's neighbors" do
      expect(mountain.neighbors({x: 1, y: 1})).to eq([{x: 1, y: 0}, {x: 2, y: 1}, {x: 1, y: 2}, {x: 0, y: 1}])
      expect(mountain.neighbors({x: 0, y: 0})).to eq([{x: 1, y: 0}, {x: 0, y: 1}])
      expect(mountain.neighbors({x: 2, y: 1})).to eq([{x: 2, y: 0}, {x: 2, y: 2}, {x: 1, y: 1}])
    end
  end

  describe "#climable_neighbors" do
    before do
      mountain.add_locations("abc")
      mountain.add_locations("hid")
      mountain.add_locations("gfe")
    end

    it "returns a given location's neighbors" do
      expect(mountain.climbable_neighbors({x: 1, y: 1})).to eq([{x: 1, y: 0}, {x: 2, y: 1}, {x: 1, y: 2}, {x: 0, y: 1}])
      expect(mountain.climbable_neighbors({x: 0, y: 0})).to eq([{x: 1, y: 0}])
      expect(mountain.climbable_neighbors({x: 2, y: 1})).to eq([{x: 2, y: 0}, {x: 2, y: 2}])
    end
  end

  describe "#traverse" do
    before do
      mountain.add_locations("SabE")
    end

    it "traverses the mountain" do
      expect { |b| mountain.traverse(&b) }.to yield_successive_args("S","a","b","E")
    end
  end
end
