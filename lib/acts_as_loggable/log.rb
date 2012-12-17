module ActsAsLoggable
  class Log < ::ActiveRecord::Base
    belongs_to :loggable, :polymorphic => true

    attr_accessible :loggable_type, :loggable_id, :logger_type, :logger_id, :context,
                    :start_date, :end_date, :description, :action_id

    ### ASSOCIATIONS:

    #has_many :taggings, :dependent => :destroy, :class_name => 'ActsAsTaggableOn::Tagging'

    ### VALIDATIONS:

    validates_presence_of :action_id
    validates_presence_of :start_date
    validates_presence_of :end_date
    validates_length_of :description, :maximum => 255

    def action
      "ActsAsLoggable::#{self.loggable_type}Action".constantize.find_by_id(self.action_id)
    end

    def loggable_path
      "/#{self.loggable_type.pluralize.downcase}/#{self.loggable_id}/logs"
    end
  end
end
