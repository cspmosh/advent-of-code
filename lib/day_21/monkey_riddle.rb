require_relative 'job'

class MonkeyRiddle
  attr_reader :monkeys, :expression

  def initialize(monkeys: [])
    @monkeys = monkeys
    @expression = build_expression
  end

  def solve
    eval(expression.print)
  end

  def solve_for_x
    left_expression = expression.left_operand
    right_expression = expression.right_operand

    linear_expression, equality_constant = left_expression.print.include?("X") ? [left_expression, eval(right_expression.print)] : [right_expression, eval(left_expression.print)]

    puts "linear expression: #{linear_expression.print}, equality value: #{equality_constant}"

    until (linear_expression.value == "X")
      left_expression = linear_expression.left_operand
      right_expression = linear_expression.right_operand
      operator = linear_expression.operator

      linear_expression, constant = left_expression.print.include?("X") ? [left_expression, find_constant(left_expression, operator, right_expression)] : [right_expression, find_constant(left_expression, operator, right_expression)]
      equality_constant = equality_constant.send(invert_operator(operator), constant)

      puts "linear expression: #{linear_expression.print}, constant: #{constant}; equality_constant: #{equality_constant}"
    end

    equality_constant
  end

private

  def find_constant(left, operator, right)
    left_expression = left.print
    right_expression = right.print

    if right_expression.include?("X")
      constant = eval(left_expression)
      constant **= -1 if operator == "/"
    else
      constant = eval(right_expression)
    end

    constant
  end

  def invert_operator(operator)
    case operator
    when "-"
      "+"
    when "+"
      "-"
    when "*"
      "/"
    when "/"
      "*"
    end
  end

  def build_expression(monkey: "root")
    args = monkeys[monkey].split

    if args.size == 1
      return VariableJob.new(args[0]) if args[0] == "X"
      return ConstantJob.new(args[0].to_i)
    end

    ExpressionJob.new(args[1], build_expression(monkey: args[0]), build_expression(monkey: args[2]))
  end
end
