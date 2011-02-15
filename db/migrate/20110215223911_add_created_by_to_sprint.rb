class AddCreatedByToSprint < ActiveRecord::Migration
  def self.up
    add_column :sprints, :created_by, :integer
  end

  def self.down
    remove_column :sprints, :created_by
  end
end
