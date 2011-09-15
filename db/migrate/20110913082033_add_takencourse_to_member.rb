class AddTakencourseToMember < ActiveRecord::Migration
  def self.up
    add_column :members, :taken_course, :boolean
  end

  def self.down
    remove_column :members, :taken_course
  end
end
