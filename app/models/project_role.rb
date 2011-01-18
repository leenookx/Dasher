class ProjectRole < ActiveRecord::Base
  belongs_to :Project
  belongs_to :User
  belongs_to :Role
end
