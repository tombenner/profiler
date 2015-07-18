directory = File.dirname(File.absolute_path(__FILE__))
Dir.glob("#{directory}/profiler/*.rb") { |file| require file }
require "#{directory}/profiler/printers/abstract_printer.rb"
Dir.glob("#{directory}/profiler/printers/*.rb") { |file| require file }

module Profiler
  class << self
    attr_accessor :profile, :is_paused

    def start
      self.profile = Profile.new
      self.is_paused = false
    end

    def pause
      self.is_paused = true
    end

    def resume
      self.is_paused = false
    end

    def check(caller_offset=0)
      raise "Profiler hasn't started yet. Please call Profiler.start first." if self.profile.nil?
      return if is_paused
      profile.check(caller_offset)
    end

    def stop
      profile.stop
    end

    def result
      profile.result
    end
  end
end
