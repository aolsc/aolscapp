class CreateMembers < ActiveRecord::Migration
  def self.up
    create_table :members do |t|
      t.integer :centerid
      t.string :firstname
      t.string :lastname
      t.string :emailid
      t.string :emailsubscribe
      t.datetime :startdate
      t.datetime :updatedate
      t.string :updateby
      t.string :deleted

      t.timestamps
    end
  end

  def self.down
    drop_table :members
  end
end
