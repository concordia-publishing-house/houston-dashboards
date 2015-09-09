require "houston/dashboards/engine"
require "houston/dashboards/configuration"

module Houston
  module Dashboards
    extend self

    def config(&block)
      @configuration ||= Dashboards::Configuration.new
      @configuration.instance_eval(&block) if block_given?
      @configuration
    end

  end
end
