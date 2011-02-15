class ProjectsController < ApplicationController
  layout 'standard'
#  before_filter :login_required, :only => [:index, :new, :create]


  # #####################################################
  #
  # #####################################################
  def index
    user = validate_user( request.headers["authentication-token"] )
    if user.nil?
      respond_to do |format|
        format.html do
          flash[:error] = 'Not authenticated.'
          redirect_to root_url
        end

        format.xml { render :xml => { :status => :error, :message => 'Invalid authentication code.'}.to_xml, :status => 403 }

        format.json { render :json => { :status => :error, :message => 'Invalid authentication code.'}.to_json, :status => 403 }
      end
    else
      projects = Project.find_all_by_owner( user.id )
      if projects
        respond_to do |format|
          format.html {     
            @title = "Dasher - Your Projects"
            @projects = Project.find_all_by_owner(@user.id)
          }
          format.xml  { render :xml => projects.to_xml( :only => [:id, :name] ) }
          format.json { render :json => projects.to_json( :only => [:id, :name] ) }
        end
      end
    end
  end


  # #####################################################
  #
  # #####################################################
  def new
    @title = "Dasher - Create a new project"
  end


  # #####################################################
  # Create a new project in the database
  # #####################################################
  def create
    if request.post? and params[:project]
      project = Project.new(params[:project])
      project.owner = @user.id
      project.save

      sprint = project.sprints.build
      sprint.name = "Backlog"
      sprint.status_id = 0
      sprint.created_by = @user.id
      sprint.save

      task = project.tasks.build
      task.name = "General"
      task.description = "General Work"
      task.type_id = 0
      task.sprint_id = sprint.id
      task.created_by = @user.id
      task.assigned_to = @user.id
      task.save

      flash[:message] = "Project '#{project.name}' has been registered."
    else
      flash[:error] = "No project data provided."
    end

    redirect_to :action => 'index'
  end

  # #####################################################
  # GET /projects/1
  # GET /projects/1.xml
  # GET /projects/1.json
  # #####################################################
  def show
    user = validate_user( request.headers["authentication-token"] )
    if user.nil?
      respond_to do |format|
        format.html do
          flash[:error] = 'Not authenticated.'
          redirect_to root_url
        end

        format.xml { render :xml => { :status => :error, :message => 'Invalid authentication code.'}.to_xml, :status => 403 }

        format.json { render :json => { :status => :error, :message => 'Invalid authentication code.'}.to_json, :status => 403 }
      end
    else
      projects = Project.find_all_by_owner( user.id )
      if projects
        respond_to do |format|
          format.html { render :action => "new" }
          format.xml  { render :xml => link.errors, :status => :unprocessable_entity }
          format.json { render :json => link.errors, :status => :unprocessable_entity }
        end
      end
    end
  end

  # #######################################################
  # Returns all of the tasks associated with the specified
  # project id.
  #
  # GET /projects/tasks/1
  # GET /projects/tasks/1.xml
  # GET /projects/tasks/1.json
  # #######################################################
  def tasks
    user = validate_user( request.headers["authentication-token"] )
    if user.nil?
      respond_to do |format|
        format.html do
          flash[:error] = 'Not authenticated.'
          redirect_to root_url
        end

        format.xml { render :xml => { :status => :error, :message => 'Invalid authentication code.'}.to_xml, :status => 403 }

        format.json { render :json => { :status => :error, :message => 'Invalid authentication code.'}.to_json, :status => 403 }
      end
    else
      projects = Task.find_all_by_project_id( params[:id] )
      if projects
        respond_to do |format|
          format.html {     
            @title = "Dasher - Your Projects"
            @projects = Project.find_all_by_owner(@user.id)
          }
          format.xml  { render :xml => projects.to_xml( :only => [:project_id, :id, :description] ) }
          format.json { render :json => projects.to_json( :only => [:project_id, :id, :description] ) }
        end
      end
    end
  end

private

  # #####################################################
  # 
  # #####################################################
  def validate_user(params)
    return @user unless @user.nil?

    if params && !params.empty?
      return User.find_by_authentication_code( params )
    else
      return nil
    end
  end
end
