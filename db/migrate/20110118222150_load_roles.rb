require 'active_record/fixtures'

class LoadRoles < ActiveRecord::Migration
  def self.up
    down
    directory = File.join(File.dirname(__FILE__), "data")
    Fixtures.create_fixtures(directory, "roles")
  end

  def self.down
    Role.delete_all
  end
end
