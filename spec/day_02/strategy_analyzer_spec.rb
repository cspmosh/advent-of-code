require "day_02/strategy_analyzer"

describe StrategyAnalyzer do
  describe "#calculate_score" do
    let(:input) { "#{opponent_shape} #{my_shape}"}

    context "when the opponent chooses rock" do
      let(:opponent_shape) { "A" }

      context "when my shape is paper" do
        let(:my_shape) { "Y" }

        it "calculates the score correctly" do
          analyzer = StrategyAnalyzer.new

          score = analyzer.calculate_score(input)
          expect(score).to eq(4)
        end
      end
    end

    context "when the opponent chooses paper" do
      let(:opponent_shape) { "B" }

      context "when my shape is a rock" do
        let(:my_shape) { "X" }

        it "calculates the score correctly" do
          analyzer = StrategyAnalyzer.new

          score = analyzer.calculate_score(input)
          expect(score).to eq(1)
        end
      end
    end

    context "when the opponent chooses scissors" do
      let(:opponent_shape) { "C" }

      context "when my shape is also scissors" do
        let(:my_shape) { "Z" }

        it "calculates the score correctly" do
          analyzer = StrategyAnalyzer.new

          score = analyzer.calculate_score(input)
          expect(score).to eq(7)
        end
      end
    end
  end

  describe "#total_points" do
    context "when multiple rounds have completed" do
      let(:input_1) { "A Y"}
      let(:input_2) { "B X"}
      let(:input_3) { "C Z"}

      it "sums the points for all rounds" do
        analyzer = StrategyAnalyzer.new
        analyzer.calculate_score(input_1)
        analyzer.calculate_score(input_2)
        analyzer.calculate_score(input_3)

        expect(analyzer.total_points).to eq(12)
      end
    end
  end
end
