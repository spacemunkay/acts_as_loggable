require "acts_as_loggable"
require "rails"

module ActsAsLoggable
  class Railtie < Rails::Railtie
    initializer 'acts_as_loggable.ar_extensions' do |app|
      if defined?(ActiveRecord::Base)
        ActiveRecord::Base.extend ActsAsLoggable::Loggable
        #ActiveRecord::Base.send :include, ActsAsLoggableOn::Logger
      end
    end
  end
end

