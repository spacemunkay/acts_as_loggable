module ActsAsLoggable
  class Log < ::ActiveRecord::Base
    belongs_to :loggable, :polymorphic => true

    attr_accessible :description, :action_id

    ### ASSOCIATIONS:

    #has_many :taggings, :dependent => :destroy, :class_name => 'ActsAsTaggableOn::Tagging'

    ### VALIDATIONS:

    validates_presence_of :action_id
    validates_presence_of :start_date
    validates_presence_of :end_date
    validates_length_of :description, :maximum => 255
  end
end
