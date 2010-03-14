class AddColumnToCourseSchedule < ActiveRecord::Migration
  def self.up
    add_column :course_schedules, :volunteer_id, :string
  end

  def self.down
    remove_column :course_schedules, :volunteer_id
  end
end
