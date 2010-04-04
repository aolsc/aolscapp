class AddUpdatedbyToCourseSchedules < ActiveRecord::Migration
  def self.up
    add_column :course_schedules, :last_updated_by, :int
  end

  def self.down
    drop_column :course_schedules, :last_updated_by
  end
end