class ProjectOwners < ActiveRecord::Migration
  def self.up
    add_column :projects, :owner, :integer
    add_column :projects, :image, :string
  end

  def self.down
    remove_column :projects, :owner
    remove_column :projects, :image
  end
end
