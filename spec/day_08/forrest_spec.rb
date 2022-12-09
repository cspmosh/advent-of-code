require 'day_08/forrest'
require 'pry'

describe Forrest do
  let(:forrest) { described_class.new }
  let(:tree_row_1) { "30373"}
  let(:tree_row_2) { "25512"}
  let(:tree_row_3) { "65332"}
  let(:tree_row_4) { "33549"}
  let(:tree_row_5) { "35390"}

  describe "#add_tree_row" do
    it "adds the row of trees to the forrest" do
      forrest.add_tree_row(tree_row_1)

      expect(forrest.trees[0]).to eq([3,0,3,7,3])
    end
  end

  describe "#visible_tree_count" do
    before do
      forrest.add_tree_row(tree_row_1)
      forrest.add_tree_row(tree_row_2)
      forrest.add_tree_row(tree_row_3)
      forrest.add_tree_row(tree_row_4)
      forrest.add_tree_row(tree_row_5)
    end

    it "counts all the trees that are visible" do
      expect(forrest.visible_tree_count).to eq(21)
    end
  end

  describe "#best_scenic_score" do
    before do
      forrest.add_tree_row(tree_row_1)
      forrest.add_tree_row(tree_row_2)
      forrest.add_tree_row(tree_row_3)
      forrest.add_tree_row(tree_row_4)
      forrest.add_tree_row(tree_row_5)
    end

    it "finds the best scenic score" do
      expect(forrest.best_scenic_score).to eq(8)
    end
  end
end
