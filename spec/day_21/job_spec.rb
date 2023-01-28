require 'day_21/job'

describe ExpressionJob do
  describe "print" do
    context "when the operands are numbers" do
      it "outputs the value of the operation" do
        job = described_class.new("+", 3, 4)
        expect(job.print).to eq("(3 + 4)")
      end
    end

    context "when the both operands are monkeys" do
      it "outputs the value of the operation" do
        monkey_abc = described_class.new("+", 1, 1)
        monkey_def = described_class.new("-", 5, 1)

        job = described_class.new("+", monkey_abc, monkey_def)

        expect(job.print).to eq("((1 + 1) + (5 - 1))")
      end
    end

    context "when the one operand is a monkey" do
      it "outputs the value of the operation" do
        monkey_abc = described_class.new("+", 1, 1)

        job = described_class.new("+", monkey_abc, 3)

        expect(job.print).to eq("((1 + 1) + 3)")
      end
    end
  end
end
