require 'day_17/cavern'
require 'day_17/rock_queue'

describe Cavern do
  let(:cavern) { described_class.new }
  let(:h4_rock) { ["####".split("")] }
  let(:plus_rock) { [".#.".split(""), "###".split(""), ".#.".split("")] }
  let(:reverse_l_rock) { ["..#".split(""), "..#".split(""), "###".split("")] }
  let(:v4_rock) { [["#"],["#"],["#"],["#"]] }
  let(:block_rock) { ["##".split(""), "##".split("")] }

  describe "#move_down" do
    before do
      cavern.spawn_new_rock(rock:, position: [2, 3])
    end

    context "when the rock is unblocked" do
      let(:rock) { h4_rock }

      it "moves the rock down" do
        cavern.move_rock_down
        cavern.display
        expect(cavern.falling_rock_at_rest?).to be false
      end
    end

    context "when the rock is a '-' shape" do
      before do
        cavern.spawn_new_rock(rock: h4_rock, position: [2, 3])
      end

      it "rests when another rock blocks it" do
        cavern.grid[3][3] = "-"
        cavern.move_rock_down

        puts cavern.display
        expect(cavern.grid).to eq([
          "|.......|".split(""),
          "|.......|".split(""),
          "|..####.|".split(""),
          "|..-....|".split(""),
          "+-------+".split("")
        ])
      end

      it "rests when another rock blocks it" do
        cavern.grid[3][4] = "-"
        cavern.move_rock_down

        expect(cavern.grid).to eq([
          "|.......|".split(""),
          "|.......|".split(""),
          "|..####.|".split(""),
          "|...-...|".split(""),
          "+-------+".split("")
        ])
      end

      it "rests when another rock blocks it" do
        cavern.grid[3][5] = "-"
        cavern.move_rock_down

        expect(cavern.grid).to eq([
          "|.......|".split(""),
          "|.......|".split(""),
          "|..####.|".split(""),
          "|....-..|".split(""),
          "+-------+".split("")
        ])
      end

      it "rests when another rock blocks it" do
        cavern.grid[3][6] = "-"
        cavern.move_rock_down

        expect(cavern.grid).to eq([
          "|.......|".split(""),
          "|.......|".split(""),
          "|..####.|".split(""),
          "|.....-.|".split(""),
          "+-------+".split("")
        ])
      end
    end

    context "when the rock is a '+' shape" do
      before do
        cavern.spawn_new_rock(rock: plus_rock, position: [2, 3])
      end

      it "rests when another rock blocks it" do
        cavern.grid[4][3] = "-"
        cavern.move_rock_down

        expect(cavern.grid).to eq([
          "|.......|".split(""),
          "|.......|".split(""),
          "|...#...|".split(""),
          "|..###..|".split(""),
          "|..-#...|".split(""),
          "|.......|".split(""),
          "+-------+".split("")
        ])
      end

      it "rests when another rock blocks it" do
        cavern.grid[5][4] = "-"
        cavern.move_rock_down

        expect(cavern.grid).to eq([
          "|.......|".split(""),
          "|.......|".split(""),
          "|...#...|".split(""),
          "|..###..|".split(""),
          "|...#...|".split(""),
          "|...-...|".split(""),
          "+-------+".split("")
        ])
      end

      it "rests when another rock blocks it" do
        cavern.grid[4][5] = "-"
        cavern.move_rock_down

        expect(cavern.grid).to eq([
          "|.......|".split(""),
          "|.......|".split(""),
          "|...#...|".split(""),
          "|..###..|".split(""),
          "|...#-..|".split(""),
          "|.......|".split(""),
          "+-------+".split("")
        ])
      end
    end

    context "when the rock is an 'L' shape" do
      before do
        cavern.spawn_new_rock(rock: l_rock, position: [2, 3])
      end

      it "rests when another rock blocks it" do
        cavern.grid[5][3] = "-"
        cavern.move_rock_down

        expect(cavern.grid).to eq([
          "|.......|".split(""),
          "|.......|".split(""),
          "|....#..|".split(""),
          "|....#..|".split(""),
          "|..###..|".split(""),
          "|..-....|".split(""),
          "+-------+".split("")
        ])
      end

      it "rests when another rock blocks it" do
        cavern.grid[5][4] = "-"
        cavern.move_rock_down

        expect(cavern.grid).to eq([
          "|.......|".split(""),
          "|.......|".split(""),
          "|....#..|".split(""),
          "|....#..|".split(""),
          "|..###..|".split(""),
          "|...-...|".split(""),
          "+-------+".split("")
        ])
      end

      it "rests when another rock blocks it" do
        cavern.grid[5][5] = "-"
        cavern.move_rock_down

        expect(cavern.grid).to eq([
          "|.......|".split(""),
          "|.......|".split(""),
          "|....#..|".split(""),
          "|....#..|".split(""),
          "|..###..|".split(""),
          "|....-..|".split(""),
          "+-------+".split("")
        ])
      end
    end

    context "when the rock is a '|' shape" do
      before do
        cavern.spawn_new_rock(rock: v4_rock, position: [2, 3])
      end

      it "rests when another rock blocks it" do
        cavern.grid[6][3] = "-"
        cavern.move_rock_down

        expect(cavern.grid).to eq([
          "|.......|".split(""),
          "|.......|".split(""),
          "|..#....|".split(""),
          "|..#....|".split(""),
          "|..#....|".split(""),
          "|..#....|".split(""),
          "|..-....|".split(""),
          "+-------+".split("")
        ])
      end
    end

    context "when the rock is a 'block' shape" do
      before do
        cavern.spawn_new_rock(rock: block_rock, position: [2, 3])
      end

      it "rests when another rock blocks it" do
        cavern.grid[4][3] = "-"
        cavern.move_rock_down

        expect(cavern.grid).to eq([
          "|.......|".split(""),
          "|.......|".split(""),
          "|..##...|".split(""),
          "|..##...|".split(""),
          "|..-....|".split(""),
          "+-------+".split("")
        ])
      end

      it "rests when another rock blocks it" do
        cavern.grid[4][4] = "-"
        cavern.move_rock_down

        expect(cavern.grid).to eq([
          "|.......|".split(""),
          "|.......|".split(""),
          "|..##...|".split(""),
          "|..##...|".split(""),
          "|...-...|".split(""),
          "+-------+".split("")
        ])
      end
    end

  end

  describe "#move_right" do
    before do
      cavern.spawn_new_rock(rock:, position: [2, 3])
    end

    context "when the rock is unblocked" do
      let(:rock) { h4_rock }

      it "moves the rock to the right" do
        cavern.move_rock_right
        expect(cavern.current_position[1]).to eq(4)
      end
    end

    context "when the rock is blocked" do
      context "when the rock is a horizontal line" do
        let(:rock) { h4_rock }

        it "does not move right when another rock blocks it" do
          cavern.grid[2][7] = "|"
          cavern.move_rock_right
          expect(cavern.current_position[1]).to eq(3)
        end
      end

      context "when the rock is a '+' shape" do
        let(:rock) { plus_rock }

        it "does not move right when another rock blocks it" do
          cavern.grid[2][5] = "|"
          cavern.move_rock_right
          expect(cavern.current_position[1]).to eq(3)
        end

        it "does not move right when another rock blocks it" do
          cavern.grid[3][6] = "|"
          cavern.move_rock_right
          expect(cavern.current_position[1]).to eq(3)
        end

        it "does not move right when another rock blocks it" do
          cavern.grid[4][5] = "|"
          cavern.move_rock_right
          expect(cavern.current_position[1]).to eq(3)
        end
      end

      context "when the rock is a reverse 'L' shape" do
        let(:rock) { reverse_l_rock }

        it "does not move right when another rock blocks it" do
          cavern.grid[2][6] = "|"
          cavern.move_rock_right
          expect(cavern.current_position[1]).to eq(3)
        end

        it "does not move right when another rock blocks it" do
          cavern.grid[3][6] = "|"
          cavern.move_rock_right
          expect(cavern.current_position[1]).to eq(3)
        end

        it "does not move right when another rock blocks it" do
          cavern.grid[4][6] = "|"
          cavern.move_rock_right
          expect(cavern.current_position[1]).to eq(3)
        end
      end

      context "when the rock is a vertical shape" do
        let(:rock) { v4_rock }

        it "does not move right when another rock blocks it" do
          cavern.grid[2][4] = "|"
          cavern.move_rock_right
          expect(cavern.current_position[1]).to eq(3)
        end

        it "does not move right when another rock blocks it" do
          cavern.grid[3][4] = "|"
          cavern.move_rock_right
          expect(cavern.current_position[1]).to eq(3)
        end

        it "does not move right when another rock blocks it" do
          cavern.grid[4][4] = "|"
          cavern.move_rock_right
          expect(cavern.current_position[1]).to eq(3)
        end

        it "does not move right when another rock blocks it" do
          cavern.grid[5][4] = "|"
          cavern.move_rock_right
          expect(cavern.current_position[1]).to eq(3)
        end
      end

      context "when the rock is a 'block' shape" do
        let(:rock) { block_rock }

        it "rests when another rock blocks it" do
          cavern.grid[2][5] = "|"
          cavern.move_rock_right
          expect(cavern.current_position[1]).to eq(3)
        end

        it "rests when another rock blocks it" do
          cavern.grid[3][5] = "|"

          cavern.display
          cavern.move_rock_right
          expect(cavern.current_position[1]).to eq(3)
        end
      end
    end
  end

  describe "#move_left" do
    context "when the rock is a horizontal line" do
      before do
        cavern.spawn_new_rock(h4_rock)
      end

      it "rests when another rock blocks it" do
        cavern.grid[0][2] = "|"
        cavern.grid[1][3] = "-"
        cavern.move_rock_left

        expect(cavern.grid).to eq([
          "|.|####.|".split(""),
          "|..-....|".split(""),
          "|.......|".split(""),
          "|.......|".split(""),
          "+-------+".split("")
        ])
      end
    end

    context "when the rock is a '+' shape" do
      before do
        cavern.spawn_new_rock(plus_rock)
      end

      it "rests when another rock blocks it" do
        cavern.grid[0][3] = "|"
        cavern.grid[3][4] = "-"
        cavern.move_rock_left

        expect(cavern.grid).to eq([
          "|..|#...|".split(""),
          "|..###..|".split(""),
          "|...#...|".split(""),
          "|...-...|".split(""),
          "|.......|".split(""),
          "|.......|".split(""),
          "+-------+".split("")
        ])
      end

      it "rests when another rock blocks it" do
        cavern.grid[1][2] = "|"
        cavern.grid[3][4] = "-"
        cavern.move_rock_left

        expect(cavern.grid).to eq([
          "|...#...|".split(""),
          "|.|###..|".split(""),
          "|...#...|".split(""),
          "|...-...|".split(""),
          "|.......|".split(""),
          "|.......|".split(""),
          "+-------+".split("")
        ])
      end

      it "rests when another rock blocks it" do
        cavern.grid[2][3] = "|"
        cavern.move_rock_left

        expect(cavern.grid).to eq([
          "|...#...|".split(""),
          "|..###..|".split(""),
          "|..|#...|".split(""),
          "|.......|".split(""),
          "|.......|".split(""),
          "|.......|".split(""),
          "+-------+".split("")
        ])
      end
    end

    context "when the rock is an 'L' shape" do
      before do
        cavern.spawn_new_rock(l_rock)
      end

      it "rests when another rock blocks it" do
        cavern.grid[0][4] = "|"
        cavern.grid[3][3] = "-"
        cavern.move_rock_left

        expect(cavern.grid).to eq([
          "|...|#..|".split(""),
          "|....#..|".split(""),
          "|..###..|".split(""),
          "|..-....|".split(""),
          "|.......|".split(""),
          "|.......|".split(""),
          "+-------+".split("")
        ])
      end

      it "rests when another rock blocks it" do
        cavern.grid[1][4] = "|"
        cavern.grid[3][3] = "-"
        cavern.move_rock_left

        expect(cavern.grid).to eq([
          "|....#..|".split(""),
          "|...|#..|".split(""),
          "|..###..|".split(""),
          "|..-....|".split(""),
          "|.......|".split(""),
          "|.......|".split(""),
          "+-------+".split("")
        ])
      end

      it "rests when another rock blocks it" do
        cavern.grid[2][2] = "|"
        cavern.grid[3][3] = "-"
        cavern.move_rock_left

        expect(cavern.grid).to eq([
          "|....#..|".split(""),
          "|....#..|".split(""),
          "|.|###..|".split(""),
          "|..-....|".split(""),
          "|.......|".split(""),
          "|.......|".split(""),
          "+-------+".split("")
        ])
      end
    end

    context "when the rock is a vertical shape" do
      before do
        cavern.spawn_new_rock(v4_rock)
      end

      it "rests when another rock blocks it" do
        cavern.grid[0][2] = "|"
        cavern.grid[4][3] = "-"
        cavern.move_rock_left

        expect(cavern.grid).to eq([
          "|.|#....|".split(""),
          "|..#....|".split(""),
          "|..#....|".split(""),
          "|..#....|".split(""),
          "|..-....|".split(""),
          "|.......|".split(""),
          "|.......|".split(""),
          "+-------+".split("")
        ])
      end

      it "rests when another rock blocks it" do
        cavern.grid[1][2] = "|"
        cavern.grid[4][3] = "-"
        cavern.move_rock_left

        expect(cavern.grid).to eq([
          "|..#....|".split(""),
          "|.|#....|".split(""),
          "|..#....|".split(""),
          "|..#....|".split(""),
          "|..-....|".split(""),
          "|.......|".split(""),
          "|.......|".split(""),
          "+-------+".split("")
        ])
      end

      it "rests when another rock blocks it" do
        cavern.grid[2][2] = "|"
        cavern.grid[4][3] = "-"
        cavern.move_rock_left

        expect(cavern.grid).to eq([
          "|..#....|".split(""),
          "|..#....|".split(""),
          "|.|#....|".split(""),
          "|..#....|".split(""),
          "|..-....|".split(""),
          "|.......|".split(""),
          "|.......|".split(""),
          "+-------+".split("")
        ])
      end

      it "rests when another rock blocks it" do
        cavern.grid[3][2] = "|"
        cavern.grid[4][3] = "-"
        cavern.move_rock_left

        expect(cavern.grid).to eq([
          "|..#....|".split(""),
          "|..#....|".split(""),
          "|..#....|".split(""),
          "|.|#....|".split(""),
          "|..-....|".split(""),
          "|.......|".split(""),
          "|.......|".split(""),
          "+-------+".split("")
        ])
      end
    end

    context "when the rock is a 'block' shape" do
      before do
        cavern.spawn_new_rock(block_rock)
      end

      it "rests when another rock blocks it" do
        cavern.grid[0][2] = "|"
        cavern.grid[2][3] = "-"
        cavern.move_rock_left

        expect(cavern.grid).to eq([
          "|.|##...|".split(""),
          "|..##...|".split(""),
          "|..-....|".split(""),
          "|.......|".split(""),
          "|.......|".split(""),
          "+-------+".split("")
        ])
      end

      it "rests when another rock blocks it" do
        cavern.grid[1][2] = "|"
        cavern.grid[2][3] = "-"
        cavern.move_rock_left

        expect(cavern.grid).to eq([
          "|..##...|".split(""),
          "|.|##...|".split(""),
          "|..-....|".split(""),
          "|.......|".split(""),
          "|.......|".split(""),
          "+-------+".split("")
        ])
      end
    end
  end
end
