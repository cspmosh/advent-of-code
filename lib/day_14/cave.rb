class Cave
  attr_reader :x_range_rocks, :y_range_rocks, :sand_source, :sand_locations, :rock_coordinates

  SAND_STATUS = { :entered_abyss => -1, :at_rest => 0, :blocked_source => -1 }.freeze

  def initialize
    @x_range_rocks = {}
    @y_range_rocks = {}
    @sand_source = {x: 500, y: 0}
    @rock_coordinates = []
    @sand_locations = []
  end

  def add_rocks(rock_ranges)
    rocks = rock_ranges.split(" -> ")

    rock_1 = rocks.shift

    until rocks.empty?
      rock_2 = rocks.first

      rock_1_coordinates = rock_1.split(",").map(&:to_i)
      rock_2_coordinates = rock_2.split(",").map(&:to_i)
      @rock_coordinates << [rock_1_coordinates[0], rock_1_coordinates[1]]

      if rock_1_coordinates[0] == rock_2_coordinates[0]
        min = [rock_1_coordinates[1], rock_2_coordinates[1]].min
        max = [rock_1_coordinates[1], rock_2_coordinates[1]].max

        if @x_range_rocks.has_key?(rock_1_coordinates[0])
          @x_range_rocks[rock_1_coordinates[0]] << (min..max)
        else
          @x_range_rocks[rock_1_coordinates[0]] = [(min..max)]
        end
      else
        min = [rock_1_coordinates[0], rock_2_coordinates[0]].min
        max = [rock_1_coordinates[0], rock_2_coordinates[0]].max

        if @y_range_rocks.has_key?(rock_1_coordinates[1])
          @y_range_rocks[rock_1_coordinates[1]] << (min..max)
        else
          @y_range_rocks[rock_1_coordinates[1]] = [(min..max)]
        end
      end

      rock_1 = rocks.shift
    end

    @rock_coordinates << [rock_2_coordinates[0], rock_2_coordinates[1]]
  end

  def add_rock_floor
    @rock_coordinates << [max_x, max_y + 2]

    @y_range_rocks[max_y] = [(0..)]
  end

  def occupied?(x:, y:)
    occupied_by_rock?(x:, y:) || occupied_by_sand?(x:, y:)
  end

  def occupied_by_rock?(x:,y:)
    return true if x_range_rocks[x].any?{ |pos| pos.cover?(y)} if x_range_rocks.has_key?(x)
    return true if y_range_rocks[y].any?{ |pos| pos.cover?(x)} if y_range_rocks.has_key?(y)

    false
  end

  def occupied_by_sand?(x:, y:)
    return true if sand_locations.find {|loc| loc[:x] == x && loc[:y] == y }
  end

  def min_x
    rock_coordinates.min_by(&:first).first
  end

  def max_x
    rock_coordinates.max_by(&:first).first
  end

  def max_y
    rock_coordinates.max_by(&:last).last
  end

  def min_y
    0
  end

  def display
    rows = max_y - min_y
    columns = max_x - min_x

    0.upto(rows + 1) do |row|
      print "%03d" % row
      -2.upto(columns + 2) do |column|
        print char_to_print(x: column + min_x, y: row + min_y)
      end
      print "\n"
    end
    puts "\n"
  end

  def entered_abyss?(x: nil, y:)
    y > max_y
  end

  def drop_sand(sand_x, sand_y)
    until occupied?(x: sand_x, y: sand_y + 1) || entered_abyss?(x: sand_x, y: sand_y)
      sand_y += 1
    end

    return SAND_STATUS[:entered_abyss] if entered_abyss?(x: sand_x, y: sand_y)

    if !occupied?(x: sand_x - 1, y: sand_y + 1)
      return drop_sand(sand_x - 1, sand_y + 1)
    end

    if !occupied?(x: sand_x + 1, y: sand_y + 1)
      return drop_sand(sand_x + 1, sand_y + 1)
    end

    # display

    @sand_locations << { x: sand_x, y: sand_y }
    return SAND_STATUS[:blocked_source] if (sand_source[:x] == sand_x && sand_source[:y] == sand_y)

    return SAND_STATUS[:at_rest]
  end

private

  def char_to_print(x:, y:)
    return "#" if occupied_by_rock?(x:, y:)
    return "+" if x == sand_source[:x] && y == sand_source[:y]
    return "o" if occupied_by_sand?(x:, y:)

    "."
  end

  def increase_max_by(n)

  end
end
