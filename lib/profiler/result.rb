module Profiler
  class Result
    attr_accessor :paths_counts, :paths_durations

    def initialize(profile)
      self.paths_counts = profile.paths_counts.dup
      self.paths_durations = profile.paths_durations.dup
    end

    def paths
      self.paths_counts.keys
    end
  end
end
