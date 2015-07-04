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
      return if is_paused
      profile.check(caller_offset)
    end

    def stop
      profile.stop
    end
  end
end
