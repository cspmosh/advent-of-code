require 'set'

class Cavern
  attr_reader :rock_queue, :falling_rock, :resting_rocks, :width, :height

  def initialize(width: 7, rock_queue: nil, display_on: false)
    @width = width
    @rock_queue = rock_queue
    @display_on = display_on
    @falling_rock = { type: nil, position: { x: 0, y: 0 }, coordinates: Set.new }
    @resting_rocks = Set.new
    @height = 0
  end

  def set_display_on(display_on)
    @display_on = display_on
  end

  def display_on?
    @display_on
  end

  def falling_rock_coordinates(offset: {x: 0, y: 0})
    return [] if falling_rock[:type].nil?

    coordinates = Set.new
    rock = falling_rock[:type]

    0.upto(rock.size - 1) do|y|
      0.upto(rock[0].size - 1) do |x|
        coordinates.add({x: falling_rock[:position][:x] + x + offset[:x], y: falling_rock[:position][:y] + y + offset[:y]}) if rock[y][x] == "#"
      end
    end

    coordinates
  end

  def spawn_new_rock(rock: rock_queue.next, position: {x: 2, y: height + 3 })
    @falling_rock[:type] = rock
    @falling_rock[:position] = position

    puts "A new rock begins falling:\n" if display_on?
    display if display_on?
  end

  def move_rock_down
    unless can_move_down?
      set_falling_rock_to_rest

      puts "Rock falls 1 unit, causing it to come to rest:\n" if display_on?
      display if display_on?

      return
    end

    falling_rock[:position][:y] -= 1

    puts "Rock falls 1 unit:\n" if display_on?
    display if display_on?
  end

  def move_rock_left
    unless can_move_left?
      puts "Jet of gas pushes rock left, but nothing happens:\n" if display_on?
      display if display_on?

      move_rock_down

      return
    end

    falling_rock[:position][:x] -= 1

    puts "Jet of gas pushes rock left:\n" if display_on?
    display if display_on?

    move_rock_down
  end

  def move_rock_right
    unless can_move_right?
      puts "Jet of gas pushes rock right, but nothing happens:\n" if display_on?
      display if display_on?

      move_rock_down

      return
    end

    falling_rock[:position][:x] += 1

    puts "Jet of gas pushes rock right:\n" if display_on?
    display if display_on?

    move_rock_down
  end

  def falling_rock_at_rest?
    falling_rock[:type].nil?
  end

  def display
    rock_coordinates = falling_rock_coordinates
    top = rock_coordinates.empty? ? height - 1 : [rock_coordinates.max_by{|rock| rock[:y]}[:y], height - 1].max

    (top).downto(0) do |y|
      print "|"

      0.upto(width - 1) do |x|
        char_to_print = "."

        char_to_print = "#" if resting_rocks.include?({x:, y:})
        char_to_print = "@" if falling_rock_coordinates.include?({x:, y:})

        print  char_to_print
      end

      print "|\n"
    end

    print "+"
    0.upto(width - 1) do
      print "-"
    end
    print "+\n\n"
  end

private

  def can_move_left?
    return false if falling_rock[:position][:x] == 0

    !resting_rocks.intersect?(falling_rock_coordinates(offset: {x: -1, y: 0}))
  end

  def can_move_right?
    return false if falling_rock[:position][:x] + falling_rock[:type][0].size == width

    !resting_rocks.intersect?(falling_rock_coordinates(offset: {x: 1, y: 0}))
  end

  def can_move_down?
    return false if falling_rock[:position][:y].zero?

    !resting_rocks.intersect?(falling_rock_coordinates(offset: {x: 0, y: -1}))
  end

  def set_falling_rock_to_rest
    rock = falling_rock[:type]

    0.upto(rock.size - 1) do|y|
      0.upto(rock[0].size - 1) do |x|
        new_y = falling_rock[:position][:y] + y
        new_x = falling_rock[:position][:x] + x
        resting_rocks.add({ x: new_x, y: new_y }) if rock[y][x] == "#"
      end
    end

    @height = falling_rock[:position][:y] + rock.size if falling_rock[:position][:y] + rock.size > height
    @falling_rock = { type: nil, position: {x: 0, y: 0} }
  end
end
