class CreateMemberCourseInterests < ActiveRecord::Migration
  def self.up
    create_table :member_course_interests do |t|
      t.integer :member_id
      t.integer :course_id
      t.date :interest_date
      t.string :deleted

      t.timestamps
    end
  end

  def self.down
    drop_table :member_course_interests
  end
end
