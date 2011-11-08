class CreateRecurringEvents < ActiveRecord::Migration
  def self.up
    create_table :recurring_events do |t|
      t.string :course_id
      t.integer :center_id
      t.datetime :start_date
      t.timestamps
    end
  end

  def self.down
    drop_table :recurring_events
  end
 
end
