class AddMemberTaggings < ActiveRecord::Migration
  def self.up
    create_table :tags do |t|
      t.column :name, :string
      t.column :center_id, :integer
      t.column :created_at, :datetime
    end

    create_table :member_taggings do |t|
      t.column :tag_id, :integer
      t.column :member_id, :integer
      t.column :created_at, :datetime
      t.column :created_by, :integer
    end

    add_index :member_taggings, :tag_id
  end

  def self.down
    drop_table :member_taggings
    drop_table :tags
  end
end