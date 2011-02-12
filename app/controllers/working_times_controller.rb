class WorkingTimesController < ApplicationController


  # #####################################################
  # GET /working_times
  # GET /working_times.xml
  # #####################################################
  def index
    @working_times = WorkingTime.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @working_times }
    end
  end


  # #####################################################
  # GET /working_times/1
  # GET /working_times/1.xml
  # #####################################################
  def show
    @working_time = WorkingTime.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @working_time }
    end
  end


  # #####################################################
  # GET /working_times/new
  # GET /working_times/new.xml
  # GET /working_times/new.json
  # #####################################################
  def new
    @working_time = WorkingTime.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @working_time }
      format.json { render :json => @working_time }
    end
  end


  # #####################################################
  # GET /working_times/1/edit
  # #####################################################
  def edit
    @working_time = WorkingTime.find(params[:id])
  end


  # #####################################################
  # Create a new record in the database.
  #
  # POST /working_times
  # POST /working_times.xml
  # POST /working_times.json
  # #####################################################
  def create

    user = validate_user( request.headers["authentication-token"] || params[:auth_code] )
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
      @working_time = WorkingTime.new(params[:working_time])

      respond_to do |format|
        @working_time.user_id = user.id
        if @working_time.save
          format.html { redirect_to(@working_time, :notice => 'WorkingTime was successfully created.') }
          format.xml  { render :xml => @working_time, :status => :created, :location => @working_time }
          format.json { render :json => @working_time, :status => :created, :location => @working_time }
        else
          format.html { render :action => "new" }
          format.xml  { render :xml => @working_time.errors, :status => :unprocessable_entity }
          format.xml  { render :json => @working_time.errors, :status => :unprocessable_entity }
        end
      end
    end
  end


  # #####################################################
  # PUT /working_times/1
  # PUT /working_times/1.xml
  # #####################################################
  def update
    @working_time = WorkingTime.find(params[:id])

    respond_to do |format|
      if @working_time.update_attributes(params[:working_time])
        format.html { redirect_to(@working_time, :notice => 'WorkingTime was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @working_time.errors, :status => :unprocessable_entity }
      end
    end
  end


  # #####################################################
  # DELETE /working_times/1
  # DELETE /working_times/1.xml
  # #####################################################
  def destroy
    @working_time = WorkingTime.find(params[:id])
    @working_time.destroy

    respond_to do |format|
      format.html { redirect_to(working_times_url) }
      format.xml  { head :ok }
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
