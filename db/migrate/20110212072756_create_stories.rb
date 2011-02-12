class CreateStories < ActiveRecord::Migration
  def self.up
    create_table :stories do |t|
      t.integer :project_id
      t.integer :sprint_id
      t.integer :status_id
      t.string :name
      t.string :description
      t.integer :user_id
      t.timestamps
    end
  end

  def self.down
    drop_table :stories
  end
end
