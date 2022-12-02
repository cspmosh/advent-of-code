require_relative 'strategy_analyzer'

analyzer = StrategyAnalyzer.new

File.foreach("data/d2_rps_strategy.txt", chomp: true) do |input|
  analyzer.calculate_score(input)
end

puts "total_score: " + analyzer.total_points.to_s
