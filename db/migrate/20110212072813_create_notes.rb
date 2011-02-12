class CreateNotes < ActiveRecord::Migration
  def self.up
    create_table :notes do |t|
      t.integer :story_id
      t.integer :user_id
      t.string :contents
      t.timestamps
    end
  end

  def self.down
    drop_table :notes
  end
end
