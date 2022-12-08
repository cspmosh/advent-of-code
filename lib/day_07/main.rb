require_relative 'directory'
require_relative 'dir_file'
require 'pry'

file = File.open("data/d7_filesystem.txt")
lines = file.readlines.map(&:chomp)
file.close

root_directory = Directory.new(name: "/")
current_dir = root_directory

lines.each do |line|
  elements = line.split

  case elements[0]
  when "$"
    if elements[1] == "cd"
      current_dir = current_dir.change_directory(elements[2])
    end

    next if elements[1] == "ls" # no action to take for list
  when "dir"
    dir = Directory.new(name: elements[1])
    current_dir.add_directory(dir)
  else
    file = DirFile.new(name: elements[1], size: elements[0].to_i)

    current_dir.add_file(file)
  end
end

total_size = 0
total_used_space = 0

root_directory.size do |name, size|
  total_size += size if size <= 100000
  total_used_space = size if name == '/'
end

puts "total used space = #{total_used_space}"

total_space = 70000000.freeze
space_needed_for_update = 30000000.freeze
total_unused_space = total_space - total_used_space

minimum_size_to_delete = space_needed_for_update - total_unused_space

puts "total unused space = #{total_unused_space}"
puts "minimum space to delete = #{minimum_size_to_delete}"

smallest_necessary_delete = total_used_space

root_directory.size do |name, size|
  if size >= minimum_size_to_delete && size < smallest_necessary_delete
    puts "#{name} size=#{size}"
    smallest_necessary_delete = size
  end
end

puts "\ntotal size: #{total_size.to_s}"
puts "smallest necessary delete: #{smallest_necessary_delete}"
