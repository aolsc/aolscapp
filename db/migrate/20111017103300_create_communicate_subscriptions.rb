class CreateCommunicationSubscriptions < ActiveRecord::Migration
  def self.up
    create_table :communication_subscriptions do |t|
      t.column :center_id, :string
      t.column :member_id, :string
    end
  end

  def self.down
    drop_table :communication_subscriptions
  end
end