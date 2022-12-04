require 'day_04/shift'

describe Shift do
  describe "#contained_by?" do
    let(:first_shift) { Shift.new("4-8") }

    it "returns true if the shift is fully covered by the other" do
      expect(Shift.new("5-7").contained_by?(first_shift)).to be true
      expect(Shift.new("8-8").contained_by?(first_shift)).to be true
    end

    it "returns false if the shift is not fully covered by the other" do
      expect(Shift.new("1-4").contained_by?(first_shift)).to be false
      expect(Shift.new("7-10").contained_by?(first_shift)).to be false
      expect(Shift.new("20-30").contained_by?(first_shift)).to be false
      expect(Shift.new("1-10").contained_by?(first_shift)).to be false
    end
  end

  describe "#overlaps_with?" do
    let(:first_shift) { Shift.new("4-8") }

    it "returns true if the schedule overlaps with the provided shift" do
      expect(Shift.new("5-7").overlaps_with?(first_shift)).to be true
      expect(Shift.new("8-8").overlaps_with?(first_shift)).to be true
      expect(Shift.new("1-4").overlaps_with?(first_shift)).to be true
      expect(Shift.new("7-10").overlaps_with?(first_shift)).to be true
      expect(Shift.new("1-10").overlaps_with?(first_shift)).to be true
    end

    it "returns false if the schedule does not overlap with the provided shift" do
      expect(Shift.new("20-30").overlaps_with?(first_shift)).to be false
      expect(Shift.new("1-3").overlaps_with?(first_shift)).to be false
    end
  end
end
