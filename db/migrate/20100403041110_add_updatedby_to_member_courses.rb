class AddUpdatedbyToMemberCourses < ActiveRecord::Migration
  def self.up
    add_column :member_courses, :last_updated_by, :int
  end

  def self.down
    drop_column :member_courses, :last_updated_by
  end
end