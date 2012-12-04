class ActsAsLoggable<%= @model.classify %>ActionsMigration < ActiveRecord::Migration

  def self.up
    create_table :<%= @model.downcase %>_actions do |t|
      t.string :action, :limit => 128
      t.timestamps
    end
  end

  def self.down
    drop_table :<%= @model.downcase %>_actions
  end

end

