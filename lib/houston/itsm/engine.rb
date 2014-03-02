module Houston
  module Itsm
    class Engine < ::Rails::Engine
      isolate_namespace Houston::Itsm
      
      # Enabling assets precompiling under rails 3.1
      if Rails.version >= '3.1'
        initializer :assets do |config|
          Rails.application.config.assets.precompile += %w(
            houston/itsm/application.js
            houston/itsm/application.css )
        end
      end
      
    end
  end
end
