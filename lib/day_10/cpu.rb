class CPU
  attr_reader :register, :cycles

  def initialize(cycles: 0)
    @register = 1
    @cycles = cycles
  end

  def add(value:, &block)
    op_cycles = 2

    1.upto(op_cycles) do |cycle|
      increment_cycles
      block.call(cycles, register) if block_given?
    end

    @register += value
  end

  def noop(&block)
    increment_cycles
    block.call(cycles, register) if block_given?
  end

  def increment_cycles
    @cycles += 1
  end

  def execute(command, &block)
    args = command.split

    case args[0]
    when "noop"
      noop(&block)
    when "addx"
      add(value: args[1].to_i, &block)
    end
  end
end
