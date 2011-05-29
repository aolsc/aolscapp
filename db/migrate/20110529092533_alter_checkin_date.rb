class AlterCheckinDate < ActiveRecord::Migration
  def self.up
    remove_column :member_attendances, :checkin_date
  end

  def self.down
    add_column :member_attendances, :checkin_date, :date
  end
end
