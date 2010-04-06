class AddVolunteerid2ToCourseSchedules < ActiveRecord::Migration
  def self.up
    add_column :course_schedules, :volunteer_id2, :int
  end

  def self.down
    drop_column :course_schedules, :volunteer_id2
  end
end