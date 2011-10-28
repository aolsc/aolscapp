class CreateMemberNotes < ActiveRecord::Migration
  def self.up
    create_table :member_notes do |t|
      t.column :note, :string
      t.column :member_id, :string
      t.column :added_by, :string
    end
  end

  def self.down
    drop_table :member_notes
  end
end