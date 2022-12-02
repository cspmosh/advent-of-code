class StrategyAnalyzer
  attr_reader :total_points

  OUTCOME = {
    "A X" => :tie, "A Y" => :win, "A Z" => :lose,
    "B X" => :lose, "B Y" => :tie, "B Z" => :win,
    "C X" => :win, "C Y" => :lose, "C Z" => :tie
  }.freeze

  SHAPE_ADJUSTMENT = {
    "A X" => "Z", "A Y" => "X", "A Z" => "Y",
    "B X" => "X", "B Y" => "Y", "B Z" => "Z",
    "C X" => "Y", "C Y" => "Z", "C Z" => "X",
  }.freeze

  SHAPE_POINTS = { "X" => 1, "Y" => 2, "Z" => 3 }.freeze
  OUTCOME_POINTS = { :lose => 0, :tie => 3, :win => 6 }.freeze

  def initialize()
    @total_points = 0
  end

  def calculate_score(input)
    opponent_shape, my_shape = input.split

    my_adjusted_shape = SHAPE_ADJUSTMENT[input]

    outcome = OUTCOME["#{opponent_shape} #{my_adjusted_shape}"]
    outcome_points = OUTCOME_POINTS[outcome]
    shape_points = SHAPE_POINTS[my_adjusted_shape]

    round_points = shape_points + outcome_points
    @total_points += round_points
    round_points
  end
end
