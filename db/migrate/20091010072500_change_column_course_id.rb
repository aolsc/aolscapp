class ChangeColumnCourseId < ActiveRecord::Migration
def self.up
    change_column :course_schedules, :course_id, :integer
  end

  def self.down
    change_column :course_schedules, :course_id, :string
  end
end