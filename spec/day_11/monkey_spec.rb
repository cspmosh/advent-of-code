require "day_11/monkey"

describe Monkey do
  let(:monkey) { described_class.new(
    id: 0,
    starting_items: [79, 98],
    operator: "*",
    operand: 19,
    divisibility_test: 23,
    test_true_monkey: 2,
    test_false_monkey: 3
  )}

  describe "#inspect_next_item" do
    it "inspects the given item and returns the worry level" do
      expect(monkey.inspect_next_item).to eq(79)
    end
  end

  describe "#determine_receiving_monkey" do
    context "when the item does not pass the divisibility test" do
      it "determines the monkey to throw to" do
        expect(monkey.determine_receiving_monkey_id(10)).to eq(3)
      end
    end

    context "when the item passes the divisibility test" do
      it "determines the monkey to throw to" do
        expect(monkey.determine_receiving_monkey_id(46)).to eq(2)
      end
    end
  end

  describe "#add_item" do
    it "adds an item to the item list" do
      monkey.add_item(40)
      expect(monkey.items).to eq([79,98,40])
    end
  end

  describe "#throw_item_to_monkey" do
    let(:monkey_2) {
      described_class.new(
        id: 1,
        starting_items: [4],
        operator: "+",
        operand: 1,
        divisibility_test: 2,
        test_true_monkey: 1,
        test_false_monkey: 2
      )
    }

    it "throws and item to another monkey" do
      monkey.throw_item_to_monkey(item: 101, monkey: monkey_2)
      expect(monkey_2.items).to include(101)
    end
  end
end
