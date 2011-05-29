class CreateMemberAttendances < ActiveRecord::Migration
  def self.up
    create_table :member_attendances do |t|
      t.integer :member_id
      t.integer :course_id
      t.date :checkin_date
      t.integer :volunteer_id
      t.timestamps
    end
  end

  def self.down
    drop_table :member_attendances
  end
end
