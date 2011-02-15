class Task < ActiveRecord::Base
  belongs_to :Project
  belongs_to :Sprint
end
