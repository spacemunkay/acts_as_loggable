module ActsAsLoggable
  module Loggable
    def acts_as_loggable
      has_many :logs, :as=>:loggable, :class_name => "ActsAsLoggable::Log"#lets not delete the logs, :dependent=>:destroy
      include InstanceMethods
    end

    module InstanceMethods
      def loggable?
        true
      end
    end
  end
end
