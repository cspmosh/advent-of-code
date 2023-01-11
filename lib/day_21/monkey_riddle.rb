require_relative 'job'

class MonkeyRiddle
  def initialize(monkeys: [])
    @number_jobs, @operation_jobs = monkeys.partition {|m| m[:job].type == :number }

    create_instance_variables
    create_getters
  end

  def solve
    until operation_jobs.empty?

      op_job = operation_jobs.shift

      if op_job[:job].operands.all? {|operand| self.respond_to?(operand)}
        input = op_job[:job].input

        op_job[:job].operands.each do |operand|
          input = input.gsub(operand, self.send(operand))
        end

        number_jobs << { monkey: op_job[:monkey], job: Job.new(eval(input).to_s) }
        create_instance_variables
        create_getters

        next
      end

      operation_jobs << op_job
    end

    root.to_i
  end

  private

  def create_instance_variables
    @number_jobs.each do |nj|
      instance_variable_set("@#{nj[:monkey]}", nj[:job].input)
    end
  end

  def create_getters
    instance_variables.each do |v|
      define_singleton_method(v.to_s.tr('@','')) do
        instance_variable_get(v)
      end
    end
  end
end
