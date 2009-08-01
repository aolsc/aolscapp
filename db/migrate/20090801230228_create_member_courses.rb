class CreateMemberCourses < ActiveRecord::Migration
  def self.up
    create_table :member_courses do |t|
      t.integer :member_id
      t.integer :course_schedule_id
      t.date :start_date
      t.date :end_date
      t.string :deleted

      t.timestamps
    end
  end

  def self.down
    drop_table :member_courses
  end
end
