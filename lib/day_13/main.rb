lines = []

def list?(element)
  element.split("").first == "["
end

def compare(left, right)
  if left.class == Integer && right.class == Integer
    print "- Compare #{left} vs #{right}\n\t"

    if left < right
      print "\t- Left side is smaller, so inputs are in the right order\n"
      return true
    end

    if left > right
      print "\t- Right side is smaller, so inputs are not in the right order\n"
      return false
    end
  end

  if left.class == Integer && right.class == Array
    print "- Mixed types; convert left to [#{left}] and retry comparison\n\t"
    return compare([left], right)
  end

  if left.class == Array && right.class == Integer
    print "- Compare #{left} vs #{right}\n\t\t"
    print "- Mixed types; convert right to [#{right}] and retry comparison\n\t\t"
    return compare(left, [right])
  end

  if left.class == Array && right.class == Array
    print "- Compare #{left} vs #{right}\n\t"

    if left.empty? && !right.empty?
      print "- Left side ran out of items, so inputs are in the right order\n\n"
      return true
    end

    0.upto(left.size - 1) do |index|
      if index == right.size
        print "- Right side ran out of items, so inputs are not in the right order\n\n"
        return false
      end

      result = compare(left[index], right[index])

      puts "" if result == true || result == false #formatting

      return result if result == true || result == false

      if index == left.size - 1 && index < right.size - 1
        print "- Left side ran out of items, so inputs are in the right order\n\n"
        return true
      end
    end
  end
end

pair = 0
total_indices = 0
packets = []

File.foreach('data/d13_input.txt', chomp: true) do |line|
  if line.empty?
    left = lines[0]
    right = lines[1]
    pair += 1

    puts "== PAIR #{pair} =="
    packets << eval(left)
    packets << eval(right)

    result = compare(eval(left), eval(right))

    total_indices += pair if result == true

    lines.clear
    next
  end

  lines << line
end

puts "total indices: #{total_indices}"

index_1 = 0
index_2 = 0

def bubble_sort_packets(packets, size)
  return if size == 0

  0.upto(size - 2) do |n|
    result = compare(packets[n], packets[n + 1])
    if result == false
      packets[n], packets[n + 1] = packets[n+1], packets[n]
    end
  end

  bubble_sort_packets(packets, size - 1)
end

bubble_sort_packets(packets, packets.size)

packets.each.with_index(1) do |element, index|
  index_1 = index if element == [[2]]
  index_2 = index if element == [[6]]
end

puts "decoder key: #{index_1 * index_2}"



