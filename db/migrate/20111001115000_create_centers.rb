class CreateCenters < ActiveRecord::Migration
  def self.up
    create_table :centers do |t|
      t.column :city, :string
      t.column :state, :string
      t.column :country, :string
    end

    remove_column :members, :centerid
    add_column :members, :center_id, :integer
    add_column :member_attendances, :center_id, :integer
  end

  def self.down
    drop_table :centers
    remove_column :members, :center_id
    remove_column :member_attendances, :center_id
  end
end