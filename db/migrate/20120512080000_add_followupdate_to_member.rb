class AddFollowupdateToMember < ActiveRecord::Migration
  def self.up
    add_column :members, :followupdate, :date
  end

  def self.down
    remove_column :members, :followupdate
  end
end
