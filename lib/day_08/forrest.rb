class Forrest
  attr_reader :trees

  def initialize
    @trees = []
  end

  def add_tree_row(trees)
    @trees << trees.split("").map(&:to_i)
  end

  def traverse(&block)
    trees.each_with_index do |row, y|
      row.each_with_index {|height, x| block.call(x, y, height)}
    end

    nil
  end

  def best_scenic_score
    best_scenic_score = 0

    traverse do |x, y, height|
      visible?(x, y, height) do |scenic_score|
        if scenic_score.to_i > best_scenic_score
          best_scenic_score = scenic_score
        end
      end
    end

    best_scenic_score
  end

  def visible_tree_count
    count = 0
    best_scenic_score = 0

    traverse do |x, y, height|
      count += 1 if visible?(x, y, height)
    end

    count
  end

private

  def on_border?(x, y)
    return true if x == 0 || y == 0 #left and top edges
    return true if y == trees.length - 1 #bottom edge
    return true if x == trees[0].length - 1 #right edge

    false
  end

  def visible?(x, y, height, &block)
    is_visible = false
    total_trees_viewed = []

    is_visible = true if on_border?(x, y)
    is_visible = true if visible_from_west?(x, y, height) { |trees_viewed| total_trees_viewed << trees_viewed }
    is_visible = true if visible_from_east?(x, y, height) { |trees_viewed| total_trees_viewed << trees_viewed }
    is_visible = true if visible_from_north?(x, y, height) { |trees_viewed| total_trees_viewed << trees_viewed }
    is_visible = true if visible_from_south?(x, y, height) { |trees_viewed| total_trees_viewed << trees_viewed }

    scenic_score = total_trees_viewed.inject(:*)

    block.call(scenic_score) if block_given?

    return is_visible
  end

  def visible_from_west?(x, y, height, &block)
    x_pos = x - 1
    trees_viewed = 0

    if x_pos < 0
      block.call(trees_viewed) if block_given?
      return false
    end

    while x_pos >= 0
      trees_viewed += 1

      if trees[y][x_pos] >= height
        block.call(trees_viewed) if block_given?
        return false
      end

      x_pos -= 1
    end

    block.call(trees_viewed) if block_given?

    return true
  end

  def visible_from_east?(x, y, height, &block)
    x_pos = x + 1
    trees_viewed = 0

    if x_pos > trees[0].length
      block.call(trees_viewed) if block_given?
      return false
    end

    while x_pos < trees[0].length
      trees_viewed += 1

      if trees[y][x_pos] >= height
        block.call(trees_viewed) if block_given?
        return false
      end

      x_pos += 1
    end

    block.call(trees_viewed) if block_given?

    return true
  end

  def visible_from_north?(x, y, height, &block)
    y_pos = y - 1
    trees_viewed = 0

    if y_pos < 0
      block.call(trees_viewed) if block_given?
      return false
    end

    while y_pos >= 0
      trees_viewed += 1

      if trees[y_pos][x] >= height
        block.call(trees_viewed) if block_given?
        return false
      end

      y_pos -= 1
    end

    block.call(trees_viewed) if block_given?

    return true
  end

  def visible_from_south?(x, y, height, &block)
    y_pos = y + 1
    trees_viewed = 0

    if y_pos >= trees.length
      block.call(trees_viewed) if block_given?
      return false
    end

    while y_pos < trees.length
      trees_viewed += 1

      if trees[y_pos][x] >= height
        block.call(trees_viewed) if block_given?
        return false
      end

      y_pos += 1
    end

    block.call(trees_viewed) if block_given?

    return true
  end
end
