require 'day_21/monkey_riddle'

describe MonkeyRiddle do
  describe "#solve" do
    it "evaluates the math expression" do
      riddle = described_class.new(monkeys: {
        "root" => "abc * def",
        "abc" => "5",
        "def" => "4"
      })
      expect(riddle.solve).to eq(20)
    end
  end

  describe "#solve_for_x" do
    context "when the expression involves addition" do
      it "evaluates the expression" do
        riddle = described_class.new(monkeys: {
          "root" => "abc == def",
          "abc" => "12",
          "def" => "humn + ghi",
          "humn" => "X",
          "ghi" => "4"
        })
        expect(riddle.solve_for_x).to eq(8)

        riddle = described_class.new(monkeys: {
          "root" => "abc == def",
          "abc" => "humn + ghi",
          "humn" => "X",
          "ghi" => "5",
          "def" => "100"
        })
        expect(riddle.solve_for_x).to eq(95)
      end
    end

    context "when the expression involves division" do
      it "evaluates the expression" do
        riddle = described_class.new(monkeys: {
          "root" => "abc == constant",
          "abc" => "def / humn",
          "def" => "4",
          "humn" => "X",
          "constant" => "12"
        })
        expect(riddle.solve_for_x).to eq(3)

        riddle = described_class.new(monkeys: {
          "root" => "abc == constant",
          "abc" => "humn / def",
          "def" => "4",
          "humn" => "X",
          "constant" => "12"
        })
        expect(riddle.solve_for_x).to eq(48)
      end
    end

    context "when the expression involves multiplication" do
      it "evaluates the expression" do
        riddle = described_class.new(monkeys: {
          "root" => "abc == constant",
          "abc" => "humn * def",
          "def" => "5",
          "humn" => "X",
          "constant" => "45"
        })
        expect(riddle.solve_for_x).to eq(9)
      end
    end

    context "when the expression involves subtraction" do
      it "evaluates the expression" do
        riddle = described_class.new(monkeys: {
          "root" => "abc == constant",
          "abc" => "humn - def",
          "def" => "4",
          "humn" => "X",
          "constant" => "12"
        })
        expect(riddle.solve_for_x).to eq(16)
      end
    end

    context "when the expression has 3 nested expressions" do
      it "evaluates the expression" do
        riddle = described_class.new(monkeys: {
          "root" => "a == constant",
          "a" => "b - f",
          "b" => "c + d",
          "c" => "humn * e",
          "d" => "20",
          "humn" => "X",
          "e" => "2",
          "f" => "g / h",
          "g" => "30",
          "h" => "3",
          "constant" => "100"
        })
        expect(riddle.solve_for_x).to eq(45)
        # "(((humn * 2) + 20) - (30 / 3)) == 100"
      end
    end
  end
end


