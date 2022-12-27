class LavaDroplet
  attr_reader :molecules

  def initialize
    @molecules = Set.new
    @surface_area = 0
    @min_x = @min_y = @min_z = 100_000
    @max_x = @max_y = @max_z = 0
  end

  def add_molecule(x:, y:, z:)
    molecules.add({x:, y:, z:})

    @min_x = x if x < min_x
    @min_y = y if y < min_y
    @min_z = z if z < min_z

    @max_x = x if x > max_x
    @max_y = y if y > max_y
    @max_z = z if z > max_z

    @surface_area += 6
    @surface_area -= 2 if molecules.include?({x: x - 1, y:, z:})
    @surface_area -= 2 if molecules.include?({x: x + 1, y:, z:})
    @surface_area -= 2 if molecules.include?({x:, y: y - 1, z:})
    @surface_area -= 2 if molecules.include?({x:, y: y + 1, z:})
    @surface_area -= 2 if molecules.include?({x:, y:, z: z - 1})
    @surface_area -= 2 if molecules.include?({x:, y:, z: z + 1})
  end

  def surface_area
    # air_pockets.each {|air_pocket| add_molecule(x: air_pocket[:x], y: air_pocket[:y], z: air_pocket[:z])}

    @surface_area
  end

private

  def min_x = @min_x
  def max_x = @max_x
  def min_y = @min_y
  def max_y = @max_y
  def min_z = @min_z
  def max_z = @max_z
  
  def air_pockets
    empty_spaces = Set.new

    (min_x + 1).upto(max_x - 1) do |x|
      (min_y + 1).upto(max_y - 1) do |y|
        (min_z + 1).upto(max_z - 1) do |z|
          empty_spaces.add({x:, y:, z:}) if !molecules.include?({x:, y:, z:})
        end
      end
    end

    empty_spaces
  end
end