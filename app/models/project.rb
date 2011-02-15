class Project < ActiveRecord::Base
  has_many :ProjectRole
  has_many :sprints
  has_many :tasks
end
