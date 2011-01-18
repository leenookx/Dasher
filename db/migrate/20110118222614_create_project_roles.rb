class CreateProjectRoles < ActiveRecord::Migration
  def self.up
    create_table :project_roles do |t|
      t.integer :user_id
      t.integer :role_id
      t.integer :project_id
      t.timestamps
    end
  end

  def self.down
    drop_table :project_roles
  end
end
