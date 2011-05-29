class AddCourseScheduleId < ActiveRecord::Migration
  def self.up
    add_column :member_attendances, :course_schedule_id, :integer
    remove_column :member_attendances, :course_id
  end

  def self.down
    remove_column :member_attendances, :course_schedule_id
    add_column :member_attendances, :course_id, :integer
  end
end
