class AddTypeToTask < ActiveRecord::Migration
  def self.up
    add_column :tasks, :type_id, :integer
  end

  def self.down
    remove_column :tasks, :type_id
  end
end
