class ProjectRolesController < ApplicationController
  # GET /project_roles
  # GET /project_roles.xml
  def index
    @project_roles = ProjectRole.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @project_roles }
    end
  end

  # GET /project_roles/1
  # GET /project_roles/1.xml
  def show
    @project_role = ProjectRole.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @project_role }
    end
  end

  # GET /project_roles/new
  # GET /project_roles/new.xml
  def new
    @project_role = ProjectRole.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @project_role }
    end
  end

  # GET /project_roles/1/edit
  def edit
    @project_role = ProjectRole.find(params[:id])
  end

  # POST /project_roles
  # POST /project_roles.xml
  def create
    @project_role = ProjectRole.new(params[:project_role])

    respond_to do |format|
      if @project_role.save
        format.html { redirect_to(@project_role, :notice => 'ProjectRole was successfully created.') }
        format.xml  { render :xml => @project_role, :status => :created, :location => @project_role }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @project_role.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /project_roles/1
  # PUT /project_roles/1.xml
  def update
    @project_role = ProjectRole.find(params[:id])

    respond_to do |format|
      if @project_role.update_attributes(params[:project_role])
        format.html { redirect_to(@project_role, :notice => 'ProjectRole was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @project_role.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /project_roles/1
  # DELETE /project_roles/1.xml
  def destroy
    @project_role = ProjectRole.find(params[:id])
    @project_role.destroy

    respond_to do |format|
      format.html { redirect_to(project_roles_url) }
      format.xml  { head :ok }
    end
  end
end
