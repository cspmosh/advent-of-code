require 'day_21/job'

describe Job do
  let(:input) {}
  let(:job) { described_class.new(input) }

  describe "type" do
    context "when the input is a number" do
      let(:input) { "3" }

      it "returns :number" do
        expect(job.type).to eq(:number)
      end
    end

    context "when the input is an operation" do
      let(:input) { "a + b" }

      it "returns :operation" do
        expect(job.type).to eq(:operation)
      end
    end
  end

  describe "operands" do
    context "when the input is a number" do
      let(:input) { "4" }

      it "returns an array with the number" do
        expect(job.operands).to eq(["4"])
      end
    end

    context "when the input is an operation" do
      let(:input) { "a + b" }

      it "returns an array with operands" do
        expect(job.operands).to eq(["a", "b"])
      end
    end
  end
end
