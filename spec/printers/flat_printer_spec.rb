require 'spec_helper'

describe Profiler::FlatPrinter do
  it "sorts by longest duration" do
    Profiler.start
    Profiler.check
    Profiler.check
    Profiler.check
    expect(STDOUT).to receive(:puts) do |string|
      lines = string.split("\n")
      durations = lines[1..3].map { |line| line.split(/\s/).first.to_f }
      expect(durations).to eq(durations.sort.reverse)
    end
    Profiler.stop
  end
end