module Profiler
  class AbstractPrinter
    attr_accessor :result

    def initialize(result)
      self.result = result
    end

    def print(options={})
      defaults = {
        output: STDOUT
      }
      options = defaults.merge(options)
      print_result(options)
    end

    private

    def print_result
      raise NotImplementedError
    end
  end
end
