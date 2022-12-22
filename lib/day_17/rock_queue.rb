class RockQueue
  attr_reader :rocks, :current_index

  def initialize
    @rocks = [rock_1, rock_2, rock_3, rock_4, rock_5]
    @current_index = 0
  end

  def next
    rock = rocks[current_index % rocks.size]
    @current_index += 1

    rock
  end

  private

  def rock_1
    rock_1 = []
    rock_1 << "####".split("")
  end

  def rock_2
    rock_2 = []
    rock_2 << ".#.".split("")
    rock_2 << "###".split("")
    rock_2 << ".#.".split("")
  end

  def rock_3
    rock_3 = []
    rock_3 << "###".split("")
    rock_3 << "..#".split("")
    rock_3 << "..#".split("")
  end

  def rock_4
    rock_4 = []
    4.times do
      rock_4 << ["#"]
    end

    rock_4
  end

  def rock_5
    rock_5 = []
    rock_5 << "##".split("")
    rock_5 << "##".split("")
  end
end

