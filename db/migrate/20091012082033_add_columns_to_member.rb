class AddColumnsToMember < ActiveRecord::Migration
  def self.up
    add_column :members, :gender, :string
    add_column :members, :agetype, :string
    add_column :members, :address1, :string
    add_column :members, :address2, :string
    add_column :members, :city, :string
    add_column :members, :state, :string
    add_column :members, :zip, :integer
    add_column :members, :country, :string
    add_column :members, :homephone, :string
    add_column :members, :cellphone, :string
    add_column :members, :employer, :string
    add_column :members, :profession, :string
    remove_column :members, :startdate
    remove_column :members, :updatedate
  end

  def self.down
    remove_column :members, :gender, :agetype, :address1, :address2, :city, :state, :zip, :country, :homephone, :cellphone, :employer, :profession
    add_column :members, :startdate, :date
    add_column :members, :updatedate, :date
  end
end
