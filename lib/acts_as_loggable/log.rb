module ActsAsLoggable
  class Log < ::ActiveRecord::Base
    belongs_to :loggable, :polymorphic => true
    belongs_to :log_action, :polymorphic => true

    #quickfix for Netzke
    belongs_to :user_action, :foreign_key => 'log_action_id'
    belongs_to :bike_action, :foreign_key => 'log_action_id'

    attr_accessible :loggable_type, :loggable_id, :logger_type, :logger_id, :context,
                    :start_date, :end_date, :description, :log_action_id, :log_action_type

    ### ASSOCIATIONS:

    #has_many :taggings, :dependent => :destroy, :class_name => 'ActsAsTaggableOn::Tagging'

    ### VALIDATIONS:

    validates_presence_of :log_action_id
    validates_presence_of :start_date
    validates_presence_of :end_date
    validates_length_of :description, :maximum => 255
    
    scope :sort_by_duration, lambda { |direction| order("(julianday(end_date) - julianday(start_date)) #{direction}") }
    


    def action
      #"ActsAsLoggable::#{self.loggable_type}Action".constantize.find_by_id(self.action_id)
      self.log_action
    end

    def loggable_path
      "/#{self.loggable_type.pluralize.downcase}/#{self.loggable_id}/logs"
    end
  end
end
