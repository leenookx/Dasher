require 'active_record/fixtures'

class PopulateTaskTypes < ActiveRecord::Migration
  def self.up
    directory = File.join(File.dirname(__FILE__), "data")
    Fixtures.create_fixtures(directory, "task_types")
  end

  def self.down
    TaskTypes.delete_all
  end
end
