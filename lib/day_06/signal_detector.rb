class SignalDetector
  class << self
    def find_marker(signal:, marker_length: 4)
      characters = signal.split("")

      index = 0

      until characters.slice(index, marker_length).uniq.length == marker_length
        index += 1
      end

      index + marker_length
    end
  end
end
