class ModifyCourseSchedules < ActiveRecord::Migration
  def self.up
    remove_column :course_schedules, :volunteer_id
    add_column :course_schedules, :volunteer_id, :integer
  end

  def self.down
    remove_column :course_schedules, :volunteer_id
    add_column :course_schedules, :volunteer_id, :string
  end
end