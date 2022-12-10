require 'day_10/cpu'

describe CPU do
  let(:cpu) { described_class.new(cycles: 10) }

  describe "#add" do
    it "runs for two cycles and at the end adds value `V` to a given register" do
      expect(cpu.register).to eq(1)
      expect { |b| cpu.add(value: 5, &b) }.to yield_successive_args([11,1], [12,1])
      expect(cpu.register).to eq(6)
    end
  end

  describe "#noop" do
    it "runs for one cycle and does nothing" do
      expect { |b| cpu.noop(&b) }.to yield_with_args(11, 1)
    end
  end

  describe "#execute" do
    before do
      allow(cpu).to receive(:add)
      allow(cpu).to receive(:noop)
    end

    context "when the command is addx" do
      it "runs the add operation to register X" do
        cpu.execute("addx 9")
        expect(cpu).to have_received(:add).with(value: 9)
      end
    end

    context "when the command is noop" do
      it "runs the noop operation" do
        cpu.execute("noop")
        expect(cpu).to have_received(:noop)
      end
    end
  end
end
