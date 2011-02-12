class RemoveUnneededTables < ActiveRecord::Migration
  def self.up
    drop_table :issues
    drop_table :stories
  end

  def self.down
  end
end
