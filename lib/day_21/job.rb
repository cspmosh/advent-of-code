class Job
  attr_accessor :input

  def initialize(input)
    @input = input
  end

  def type
    args = input.split(" ")
    args.size > 1 ? :operation : :number
  end

  def operands
    input.split(/ [-+*\/] /)
  end
end
