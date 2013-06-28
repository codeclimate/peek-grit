require 'atomic'

module Peek
  module Views
    class Grit < View
      class << self
        attr_accessor :command_time, :command_count
      end

      self.command_count = Atomic.new(0)
      self.command_time = Atomic.new(0)

      def duration
        self.class.command_time.value
      end

      def formatted_duration
        ms = duration

        if ms >= 1000
          "%.2fms" % ms
        else
          "%.0fms" % ms
        end
      end

      def calls
        self.class.command_count.value
      end

      def results
        { :duration => formatted_duration, :calls => calls }
      end

      private

      def setup_subscribers
        # Reset each counter when a new request starts
        before_request do
          self.class.command_time.value = 0
          self.class.command_count.value = 0
        end
      end
    end
  end
end
