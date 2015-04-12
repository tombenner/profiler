module Profiler
  class Profile
    attr_accessor :previous_line, :previous_time, :paths_counts, :paths_durations

    def initialize
      self.paths_counts = Hash.new(0)
      self.paths_durations = Hash.new(0)
      self.previous_line = nil
      self.previous_time = Time.now.to_f
    end

    def check(caller_offset=0)
      now = Time.now.to_f
      line = caller[caller_offset + 1].split("/")[-1]
      path = "#{self.previous_line} -> #{line}"
      self.paths_counts[path] += 1
      self.paths_durations[path] += now - self.previous_time
      self.previous_line = line.freeze
      self.previous_time = now
    end

    def stop
      result = Result.new(self)
      FlatPrinter.new(result).print
      result
    end
  end
end
