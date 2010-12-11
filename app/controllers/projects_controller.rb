class ProjectsController < ApplicationController
  layout 'standard'
  before_filter :login_required

  def index
    @title = "Dasher - Your Projects"

    @projects = Project.find_all_by_owner(@user.id)
  end

  def new
    @title = "Dasher - Create a new project"
  end

  def create
    if request.post? and params[:project]
      @project = Project.new(params[:project])
      @project.owner = @user.id
      @project.save

      flash[:message] = "Project '#{@project.name}' has been registered."
    else
      flash[:error] = "No project data provided."
    end

    redirect_to :action => 'index'
  end
end
