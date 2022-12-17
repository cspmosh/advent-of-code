class Valve
  attr_reader :name, :flow_rate, :connected_valves

  def initialize(name:, flow_rate:, connected_valves:)
    @name = name
    @flow_rate = flow_rate
    @connected_valves = connected_valves
    @is_open = false
  end

  def connect_to_valve(valve)
    @connected_valves << valve
  end

  def open_valve
    @is_open = true
  end

  def open?
    @is_open
  end
end
