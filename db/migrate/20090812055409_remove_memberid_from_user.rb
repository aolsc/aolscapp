class RemoveMemberidFromUser < ActiveRecord::Migration
  def self.up
    remove_column :users, :memberid
  end

  def self.down
    add_column :users, :memberid, :integer
  end
end
