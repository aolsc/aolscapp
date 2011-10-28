class AddCreatedateToMembernotes < ActiveRecord::Migration
  def self.up
    add_column :member_notes, :created_at, :datetime
  end

  def self.down
    remove_column :member_notes, :created_at
  end
end
