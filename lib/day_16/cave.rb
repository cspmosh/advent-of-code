class Cave
  attr_reader :valves, :minutes, :current_valve

  def initialize
    @valves = []
    @total_time = 30
    @minutes = 0
    @current_valve = nil
  end

  def add_valve(valve)
    @valves << valve
    @current_valve = valve if @current_valve.nil?
  end

  def visit_valve(name:)
    @minutes += 1
    @current_valve = valves.find { |valve| valve.name == name }

    puts "You move to valve #{current_valve.name}"
  end

  def stay
    @minutes += 1
  end

  def open_valve(valve)
    return if valve.open?

    @minutes += 1
    valve.open_valve

    puts "You open valve #{valve.name}."
  end

  def time_up?
    timer == 0
  end

  def report_time
    puts "== Minute #{minutes + 1} =="
  end

  def timer
    @total_time - minutes
  end

  def report_open_valves
    open_valves = valves.select {|valve| valve.open? }

    if open_valves.empty?
      puts "No valves are open."
      return
    end
  end
end
