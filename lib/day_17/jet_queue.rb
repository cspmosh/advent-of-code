class JetQueue
  attr_reader :pattern

  def initialize(file:)
    file = File.open(file)
    @pattern = file.read.chomp.split("")

    file.close
  end

  def next
    direction = pattern.shift
    pattern << direction

    direction
  end
end
