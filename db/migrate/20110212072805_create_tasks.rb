class CreateTasks < ActiveRecord::Migration
  def self.up
    create_table :tasks do |t|
      t.integer :sprint_id
      t.integer :status_id
      t.string :name
      t.string :description
      t.timestamps
    end
  end

  def self.down
    drop_table :tasks
  end
end
