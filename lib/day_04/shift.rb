class Shift
  attr_reader :first_day, :last_day, :range

  def initialize(range_text)
    @first_day, @last_day = range_text.split("-").map(&:to_i)
  end

  def range
    (first_day..last_day)
  end

  def contained_by?(other_shift)
    other_shift.range.cover?(first_day) && other_shift.range.cover?(last_day) #503
  end

  def overlaps_with?(other_shift)
    other_shift.range.cover?(first_day) || other_shift.range.cover?(last_day) ||
    range.cover?(other_shift.first_day) || range.cover?(other_shift.last_day)
  end
end
