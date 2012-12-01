module ActsAsLoggable
  module Loggable
    def acts_as_loggable
      has_many :logs, :as=>:loggable#lets not delete the logs, :dependent=>:destroy
      include InstanceMethods
    end

    module InstanceMethods
      def taggable?
        true
      end
    end
  end
end
