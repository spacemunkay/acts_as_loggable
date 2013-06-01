module ActsAsLoggable
  class Log < ::ActiveRecord::Base
    belongs_to :loggable, :polymorphic => true
    belongs_to :logger, :polymorphic => true
    belongs_to :log_action, :polymorphic => true

    #quickfix for Netzke
    belongs_to :user_action, :foreign_key => 'log_action_id'
    belongs_to :bike_action, :foreign_key => 'log_action_id'
    belongs_to :transaction_action, :foreign_key => 'log_action_id'

    attr_accessible :loggable_type, :loggable_id, :logger_type, :logger_id, :context,
                    :start_date, :end_date, :description, :log_action_id, :log_action_type,
                    :copy_log, :copy_type, :copy_id, :copy_action_id, :copy_action_type #virtual attributes

    #virtual attributes for copy convenience callback
    attr_accessor :copy_log, :copy_type, :copy_id, :copy_action_id, :copy_action_type

    #provide a convenience copy ability
    before_save :check_copy_log

    ### ASSOCIATIONS:

    #has_many :taggings, :dependent => :destroy, :class_name => 'ActsAsTaggableOn::Tagging'

    ### VALIDATIONS:

    validates_presence_of :log_action_id
    validates_presence_of :start_date
    validates_presence_of :end_date
    validates_length_of :description, :maximum => 255
    validate :end_date_cannot_be_set_without_start_date
    validate :end_date_cannot_be_before_start_date

    scope :sort_by_duration, lambda { |direction| order("(julianday(end_date) - julianday(start_date)) #{direction}") }

    def check_copy_log
      if self.copy_log == true or self.copy_log == "on" #needed to check for on because of extJS fieldsets
        log_copy = self.dup
        log_copy.update_attributes( { :loggable_type => self.copy_type,
                                      :loggable_id => self.copy_id,
                                      :log_action_id => self.copy_action_id,
                                      :log_action_type => self.copy_action_type,
                                      :copy_log => false} )
      end
    end

    def action
      #"ActsAsLoggable::#{self.loggable_type}Action".constantize.find_by_id(self.action_id)
      self.log_action
    end

    def loggable_path
      "/#{self.loggable_type.pluralize.downcase}/#{self.loggable_id}/logs"
    end

    def end_date_cannot_be_set_without_start_date
      if end_date && !start_date
        errors.add(:end_date, "can't be set without a start_date")
      end
    end

    def end_date_cannot_be_before_start_date
      if end_date && start_date && end_date < start_date
        errors.add(:end_date, "can't be before start_date")
      end
    end
  end
end
