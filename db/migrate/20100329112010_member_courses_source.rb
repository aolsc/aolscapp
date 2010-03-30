class MemberCoursesSource < ActiveRecord::Migration
  def self.up
    add_column :member_courses, :referral_source, :string
  end

  def self.down
    remove_column :member_courses, :referral_source
  end
end