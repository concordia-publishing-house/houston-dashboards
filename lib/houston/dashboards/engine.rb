module Houston
  module Dashboards
    class Engine < ::Rails::Engine
      isolate_namespace Houston::Dashboards
      
      initializer :assets do |config|
        Rails.application.config.assets.precompile += %w(
          houston/dashboards/application.js
          houston/dashboards/application.css )
      end
      
    end
  end
end
