class CreateSprints < ActiveRecord::Migration
  def self.up
    create_table :sprints do |t|
      t.string :name, :null => false
      t.integer :project_id
      t.integer :status_id
      t.datetime :start_date
      t.datetime :end_date
      t.timestamps
    end
  end

  def self.down
    drop_table :sprints
  end
end
