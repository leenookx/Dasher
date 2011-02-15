class Sprint < ActiveRecord::Base
  belongs_to :Project
  has_many :Tasks
end
