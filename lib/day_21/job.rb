class Job
  attr_reader :value

  def initialize(value)
    @value = value
  end

  def print
    value.to_s
  end
end

class ConstantJob < Job; end
class VariableJob < Job; end

class ExpressionJob < Job
  attr_reader :operator, :left_operand, :right_operand

  def initialize(operator, left_operand, right_operand)
    @operator = operator
    @left_operand = left_operand
    @right_operand = right_operand
  end

  def print
    left = left_operand.class == Integer || left_operand == "X" ? left_operand : left_operand.print
    right = right_operand.class == Integer  || right_operand == "X" ? right_operand : right_operand.print

    "(#{left} #{operator} #{right})"
  end
end
