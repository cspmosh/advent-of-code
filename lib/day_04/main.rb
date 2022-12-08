require_relative 'shift'

fully_contained_shifts = 0
overlapping_shifts = 0

DirFile.foreach("data/d4_section_assignments.txt", chomp: true) do |schedules|
  shift_range_1, shift_range_2 = schedules.split(",")
  shift_1 = Shift.new(shift_range_1)
  shift_2 = Shift.new(shift_range_2)

  fully_contained_shifts += 1 if shift_1.contained_by?(shift_2) || shift_2.contained_by?(shift_1)
  overlapping_shifts += 1 if shift_1.overlaps_with?(shift_2)
end

puts "fully contained shifts: " + fully_contained_shifts.to_s
puts "overlapping shifts: " + overlapping_shifts.to_s
