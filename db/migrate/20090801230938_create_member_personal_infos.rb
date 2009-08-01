class CreateMemberPersonalInfos < ActiveRecord::Migration
  def self.up
    create_table :member_personal_infos do |t|
      t.integer :member_id
      t.string :gender
      t.string :agetype
      t.string :address1
      t.string :address2
      t.string :city
      t.string :state
      t.integer :zip
      t.string :country
      t.string :homephone
      t.string :cellphone
      t.string :employer
      t.string :profession
      t.string :deleted

      t.timestamps
    end
  end

  def self.down
    drop_table :member_personal_infos
  end
end
