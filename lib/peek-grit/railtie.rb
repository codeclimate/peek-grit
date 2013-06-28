module Peek
  module Grit
    class Railtie < ::Rails::Engine
      initializer "grit.peek.instrumentation" do |app|
        require "peek-grit/log_subscriber"
        LogSubscriber.attach_to :grit
      end
    end
  end
end
