class RopeBridge
  attr_reader :tail_movements, :knots

  def initialize(knot_count: 2)
    @knots = []
    knot_count.times { |_knot| @knots << {x: 0, y: 0}}
    @tail_movements = [{x: 0, y: 0}]
  end

  def track_tail_movement(x:, y:)
    @tail_movements << { x: x, y: y }
  end

  def move_head(instructions)
    direction, distance = instructions.split(" ")

    case direction
    when "R"
      distance.to_i.times do |n|
        @knots[0] = { x: knots[0][:x] + 1, y: knots[0][:y] }

        follow_knot(1) if distance_between_knots(1, 2) > 1
      end
    when "L"
      distance.to_i.times do |n|
        @knots[0] = { x: knots[0][:x] - 1, y: knots[0][:y] }

        follow_knot(1) if distance_between_knots(1, 2) > 1
      end
    when "U"
      distance.to_i.times do |n|
        @knots[0] = { x: knots[0][:x], y: knots[0][:y] + 1 }

        follow_knot(1) if distance_between_knots(1, 2) > 1
      end
    when "D"
      distance.to_i.times do |n|
        @knots[0] = { x: knots[0][:x], y: knots[0][:y] - 1 }

        follow_knot(1) if distance_between_knots(1, 2) > 1
      end
    end
  end

  def uniq_tail_positions_count
    tail_movements.uniq.count
  end

  def head_position
    @knots[0]
  end

private

  def distance_between_knots(knot_1 = 1, knot_2 = 2)
    knot_a = knots[knot_1 - 1]
    knot_b = knots[knot_2 - 1]

    [(knot_a[:x] - knot_b[:x]).abs, (knot_a[:y] - knot_b[:y]).abs].max
  end

  def follow_knot(knot_number)
    leading_knot = knots[knot_number - 1]
    following_knot = knots[knot_number]

    new_x, new_y = leading_knot[:x], leading_knot[:y]

    if leading_knot[:x] < following_knot[:x]
      new_x = following_knot[:x] - 1
    end

    if leading_knot[:x] > following_knot[:x]
      new_x = following_knot[:x] + 1
    end

    if leading_knot[:y] < following_knot[:y]
      new_y = following_knot[:y] - 1
    end

    if leading_knot[:y] > following_knot[:y]
      new_y = following_knot[:y] + 1
    end

    knots[knot_number] = { x: new_x, y: new_y }

    if knot_number == knots.length - 1
      track_tail_movement(x: new_x, y: new_y)
    else
      #recursively call follow_knot for each knot
      follow_knot(knot_number + 1) if distance_between_knots(knot_number + 1, knot_number + 2) > 1
    end
  end
end
