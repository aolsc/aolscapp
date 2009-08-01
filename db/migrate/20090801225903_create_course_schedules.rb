class CreateCourseSchedules < ActiveRecord::Migration
  def self.up
    create_table :course_schedules do |t|
      t.string :course_id
      t.string :displayname
      t.integer :center_id
      t.datetime :start_date
      t.datetime :end_date
      t.string :location_name
      t.string :address1
      t.string :address2
      t.string :city
      t.string :state
      t.string :country
      t.string :teacher_name
      t.string :deleted

      t.timestamps
    end
  end

  def self.down
    drop_table :course_schedules
  end
end
