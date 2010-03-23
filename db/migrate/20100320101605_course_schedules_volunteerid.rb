class CourseSchedulesVolunteerid < ActiveRecord::Migration
  def self.up
    remove_column :course_schedules, :teacher_name
    add_column :course_schedules, :teacher_id, :integer
  end

  def self.down
    add_column :course_schedules, :teacher_name, :string
    remove_column :course_schedules, :teacher_id
  end
end