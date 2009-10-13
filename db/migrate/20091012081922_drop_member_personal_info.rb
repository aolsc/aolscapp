class DropMemberPersonalInfo < ActiveRecord::Migration
  def self.up
    drop_table :member_personal_infos
  end
end