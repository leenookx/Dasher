class UserController < ApplicationController
  include ApplicationHelper
  layout 'standard'
  before_filter :login_required, :only => :my_account


  # #####################################################
  # 
  # #####################################################
  def login
    @title = "Dasher - Login"
  end


  # #####################################################
  # 
  # #####################################################
  def process_login
    if request.post? && params[:user]
      @user = User::FindByName(params[:user])
      if @user
        if @user.status == User::STATUS_OK
          if @user.authenticate?(params[:user])
            # Remember the user's id during this session
            session[:id] = @user.id

            if @user.remember_me?
              @user.remember!(cookies)
            else
              @user.forget!(cookies)
            end

            AuditTrail.create_login_entry(session, request.remote_ip)

            redirect_to session[:return_to] || root_url
          else
            flash[:error] = 'Invalid login.'
            redirect_to :action => 'login', :name => params[:user][:name]
          end
        else
          if @user.status == User::STATUS_AWAITING_VALIDATION
          elsif @user.status == User::STATUS_DISABLED
          else
          end
        end
      else
        flash[:error] = 'Invalid login.'
        redirect_to :action => 'login', :name => params[:user][:name]
      end
    else
      redirect_to root_url
    end
  end


  # #####################################################
  # 
  # #####################################################
  def logout
    AuditTrail.create_logout_entry(session, request.remote_ip)
    User.logout!(session, cookies)

    reset_session
    flash[:message] = 'Logged out.'
    redirect_to :action => 'login'
  end


  # #####################################################
  # 
  # #####################################################
  def my_account
    @title = "Dasher - Your account."
  end


  # #####################################################
  # 
  # #####################################################
  def register
    if request.get?
      @title = "Spengler - Register"
    elsif request.post? and params[:user]
      @user = User.new(params[:user])
      @user.password = "password"
      if @user.save
        flash[:message] = "User #{@user.name} has been registered. You will receive an activation code via email."

        AuditTrail.create_registration_entry(request.remote_ip, @user.id)

        a = Activation.new
        a.user_id = @user.id
        a.save

        Delayed::Job.enqueue( UserCodeSenderJob.new(@user.id, request.remote_ip) )

        redirect_to session[:return_to] || root_url
      end
    end
  end

  # #####################################################
  # 
  # #####################################################
  def activate
    if request.get?
      @activation = Activation.find_by_code(params[:id])
      if @activation
        @title = "Dasher - Activate Your Account"
      else
        flash[:message] = "Invalid activation code."
        redirect_to root_url
      end
    elsif request.post? and params[:user]
      activation = Activation.find_by_code(params[:id])
      if activation
        if params[:user][:password] == params[:user][:password_confirm]
          @user = User.find(activation.user_id)
          if @user
            @user.update_attributes( params[:user] )
            @user.password = params[:user][:password]
            @user.status = User::STATUS_OK
            
            if @user.save
              flash[:message] = "Thank you. Your user is now active."

              # We can also remove the activation.
              activation.destroy

              redirect_to :action => 'my_account'
            else
              flash[:error] = "Unable to save the user."
            end
          else
            flash[:error] = "Invalid user."
            redirect_to root_url
          end
        else
          flash[:error] = "Passwords don't match."
        end
      else
        flash[:error] = "Invalid activation code."
        redirect_to root_url
      end
    end
  end

  # ##################################################################
  # Invite someone to the site based on this users' friends.
  # ##################################################################
  def invite
    if request.post?
      if logged_in?
        if @user.invite?( params[:email], request.remote_ip )
          flash[:notice] = "Thank you, invitation sent."
          render :update do |page|
            page.replace_html 'invitations-remaining', :partial => 'invitations/invitations_remaining', :locals => { :user => @user }
          end
        else
          flash[:error] = "Couldn't create the invitation. Probably there is already a pending invite for that email address."
          render :update do |page|
            page.replace_html 'invitations-remaining', :partial => 'invitations/invitations_remaining', :locals => { :user => @user }
          end
        end
      else
        flash[:error] = "You are not logged in and cannot use this function."
        render :update do |page|
          page.replace_html 'invitations-remaining', :partial => 'invitations/invitations_remaining', :locals => { :user => @user }
        end
      end
    else
      redirect_to root_url
    end
  end
end
