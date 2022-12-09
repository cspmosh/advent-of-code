require 'day_09/rope_bridge'

describe RopeBridge do
  let(:rope_bridge) { described_class.new }

  describe "#track_tail_movement" do
    it "adds to a list of location coordinates" do
      rope_bridge.track_tail_movement(x: 2, y: 3)

      expect(rope_bridge.tail_movements).to include({x: 0, y: 0}, {x: 2, y: 3})
    end
  end

  describe "#move_head" do
    it "moves the head knot to the right" do
      rope_bridge.move_head("R 4")

      expect(rope_bridge.head_position).to eq({x: 4, y: 0})
      expect(rope_bridge.tail_movements).to eq([
        {x: 0, y: 0},
        {x: 1, y: 0},
        {x: 2, y: 0},
        {x: 3, y: 0}
      ])
    end

    it "moves the head knot to the left" do
      rope_bridge.move_head("L 4")

      expect(rope_bridge.head_position).to eq({x: -4, y: 0})
      expect(rope_bridge.tail_movements).to eq([
        {x: 0, y: 0},
        {x: -1, y: 0},
        {x: -2, y: 0},
        {x: -3, y: 0}
      ])
    end

    it "moves the head knot up" do
      rope_bridge.move_head("U 4")

      expect(rope_bridge.head_position).to eq({x: 0, y: 4})
      expect(rope_bridge.tail_movements).to eq([
        {x: 0, y: 0},
        {x: 0, y: 1},
        {x: 0, y: 2},
        {x: 0, y: 3}
      ])
    end

    it "moves the head knot down" do
      rope_bridge.move_head("D 4")

      expect(rope_bridge.head_position).to eq({x: 0, y: -4})
      expect(rope_bridge.tail_movements).to eq([
        {x: 0, y: 0},
        {x: 0, y: -1},
        {x: 0, y: -2},
        {x: 0, y: -3}
      ])
    end
  end

  describe "#uniq_tail_positions_count" do
    before do
      rope_bridge.move_head("R 4")
      rope_bridge.move_head("U 4")
      rope_bridge.move_head("L 3")
      rope_bridge.move_head("D 1")
      rope_bridge.move_head("R 4")
      rope_bridge.move_head("D 1")
      rope_bridge.move_head("L 5")
      rope_bridge.move_head("R 2")
    end

    it "returns the number of positions that the tail visited at least once" do
      expect(rope_bridge.uniq_tail_positions_count).to eq(13)
    end
  end
end
