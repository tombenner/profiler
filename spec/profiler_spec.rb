require 'spec_helper'

describe Profiler do
  describe "profiling" do
    before :each do
      expect(STDOUT).to receive(:puts)
    end

    it "records one path" do
      Profiler.start
      Profiler.check
      result = Profiler.stop
      expect(result.paths.length).to eq(1)
    end

    it "records two paths" do
      Profiler.start
      Profiler.check
      Profiler.check
      result = Profiler.stop
      expect(result.paths.length).to eq(2)
    end

    it "records one call" do
      Profiler.start
      Profiler.check
      result = Profiler.stop
      expect(result.paths_counts.values).to eq([1])
    end

    it "records multiple calls" do
      Profiler.start
      5.times do
        Profiler.check
      end
      result = Profiler.stop
      expect(result.paths_counts.values).to eq([1, 4])
    end

    it "records paths" do
      Profiler.start
      Profiler.check
      result = Profiler.stop
      expect(result.paths.length).to eq(1)
      expect(result.paths.first).to start_with(' -> profiler_spec.rb:')
    end

    it "records durations" do
      Profiler.start
      Profiler.check
      result = Profiler.stop
      expect(result.paths_durations.length).to eq(1)
      expect(result.paths_durations.values.first).to be_between(0, 0.1)
    end

    it "pauses and resumes" do
      Profiler.start
      Profiler.check
      Profiler.pause
      Profiler.check
      Profiler.resume
      Profiler.check
      result = Profiler.stop
      expect(result.paths.length).to eq(2)
    end
  end
end