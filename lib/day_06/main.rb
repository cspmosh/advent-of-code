require_relative 'signal_detector'

signal = File.read("data/d6_signal_data.txt")

puts SignalDetector.find_marker(signal: signal).to_s

