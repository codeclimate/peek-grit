module Peek
  module Grit
    class LogSubscriber < ActiveSupport::LogSubscriber
      def query(event)
        Peek::Views::Grit.command_time.update { |value| value + event.duration }
        Peek::Views::Grit.command_count.update { |value| value + 1 }
      end
    end
  end
end
