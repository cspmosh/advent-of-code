require_relative 'forrest'

forrest = Forrest.new

File.foreach("data/d8_trees.txt", chomp: true) do |row|
  forrest.add_tree_row(row)
end

puts "total visible trees: #{forrest.visible_tree_count}"
