class AlterZipToString < ActiveRecord::Migration
def self.up
    change_column :members, :zip, :string
  end

  def self.down
    change_column :members, :zip, :integer
  end
end