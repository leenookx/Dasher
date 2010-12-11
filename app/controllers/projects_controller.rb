class ProjectsController < ApplicationController
  layout 'standard'
  before_filter :login_required

  def index
    @title = "Dasher - Your Projects"
  end

  def new
    @title = "Dasher - Create a new project"
  
    @project = Project.new
  end
end
