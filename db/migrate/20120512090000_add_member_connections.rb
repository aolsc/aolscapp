class AddMemberConnections < ActiveRecord::Migration
  def self.up
    create_table :member_connections do |t|
      t.column :member_id, :integer
      t.column :created_at, :datetime
      t.column :created_by, :integer
    end
  end

  def self.down
    drop_table :member_connections
  end
end