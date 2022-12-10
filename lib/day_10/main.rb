require_relative "cpu"
require_relative "crt"

cpu = CPU.new
monitor = CRT.new

def signal_strength(cycle, reg_value)
  cycle * reg_value
end

total_signal_strength = 0

File.foreach('data/d10_input.txt', chomp: true) do |line|
  cpu.execute(line) do |cycle, reg_value|
    if (cycle - 20) % 40 == 0
      total_signal_strength += signal_strength(cycle, reg_value)
    end
  end
end

puts "total_signal_strength: #{total_signal_strength}\n"

cpu_2 = CPU.new
current_reg_value = 1

File.foreach('data/d10_input.txt', chomp: true) do |line|
  cpu_2.execute(line) do |cycle, reg_value|

    if current_reg_value != reg_value
      current_reg_value = reg_value
      monitor.move_sprite(reg_value)
    end

    print "\n" if (cycle - 1) % 40 == 0
    pixel = (cycle - 1) % 40

    monitor.draw_pixel(pixel)
  end
end



