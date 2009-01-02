class UsersController < ApplicationController
  # Be sure to include AuthenticationSystem in Application Controller instead

  layout 'reg'

  # render new.rhtml
  def new
  end

  def create
    cookies.delete :auth_token
    # protects against session fixation attacks, wreaks havoc with 
    # request forgery protection.
    # uncomment at your own risk
    # reset_session


    @user = User.new(params[:user])
    @user.save
    if @user.errors.empty?
      self.current_user = @user
      
      f = Follower.new
      f.idno = session[:stud_idno]
      f.user_id = @user.id
      f.save

      profile = Profile.find(session[:stud_idno])
      flash[:notice] = "#{profile.fullname}"
      render :action => "finish"
     
    end
  end
  
  def finish
    
  end

  def show
    
  end

end
