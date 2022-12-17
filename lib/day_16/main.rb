require_relative 'valve'
require_relative 'cave'

cave = Cave.new

File.foreach("data/day_16/sample.txt", chomp: true) do |line|
  left, right = line.split("; ")

  values = left.split(" ")

  name = values[1]
  flow_rate = values[4].split("=")[1].to_i

  connected_valve_names = right.split(", ")
  connected_valve_names[0] = connected_valve_names[0].split(" ")[4]

  valve = Valve.new(name:, flow_rate:, connected_valves: connected_valve_names)
  cave.add_valve(valve)
end

cave.report_time
cave.report_open_valves


puts cave.timer

cave.visit_valve(name: "DD")

puts cave.timer



