class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.integer :memberid
      t.string :username
      t.string :password
      t.string :updateby
      t.datetime :updatedate
      t.string :deleted
      t.timestamps
    end
  end

  def self.down
    drop_table :users
  end
end
