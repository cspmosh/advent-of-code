require 'day_06/signal_detector'

describe SignalDetector do
  describe ".find_marker" do
    let(:signal_1) { "mjqjpqmgbljsphdztnvjfqwrcgsmlb" }
    let(:signal_2) { "bvwbjplbgvbhsrlpgdmjqwftvncz" }
    let(:signal_3) { "nppdvjthqldpwncqszvftbrmjlhg" }
    let(:signal_4) { "nznrnfrfntjfmvfwmzdfjlvtqnbhcprsg" }
    let(:signal_5) { "zcfzfwzzqfrljwzlrfnpqdbhtmscgvjw" }

    context "when the marker is 4 characters long" do
      it "returns the last position of the first 4 character unique sequence" do
        expect(described_class.find_marker(signal: signal_1)).to eq(7)
        expect(described_class.find_marker(signal: signal_2)).to eq(5)
        expect(described_class.find_marker(signal: signal_3)).to eq(6)
        expect(described_class.find_marker(signal: signal_4)).to eq(10)
        expect(described_class.find_marker(signal: signal_5)).to eq(11)
      end
    end

    context "when the marker is 14 characters long" do
      it "returns the last position of the first 14 character unique sequence" do
        expect(described_class.find_marker(signal: signal_1, marker_length: 14)).to eq(19)
        expect(described_class.find_marker(signal: signal_2, marker_length: 14)).to eq(23)
        expect(described_class.find_marker(signal: signal_3, marker_length: 14)).to eq(23)
        expect(described_class.find_marker(signal: signal_4, marker_length: 14)).to eq(29)
        expect(described_class.find_marker(signal: signal_5, marker_length: 14)).to eq(26)
      end
    end
  end
end
