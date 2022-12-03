class Prioritizer

  PRIORITY = ('a'..'z').to_a.concat(('A'..'Z').to_a).freeze

  class << self
    def call(item)
      PRIORITY.index(item) + 1
    end
  end
end
