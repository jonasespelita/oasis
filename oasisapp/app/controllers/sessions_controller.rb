# This controller handles the login/logout function of the site.  
class SessionsController < ApplicationController
  # Be sure to include AuthenticationSystem in Application Controller instead
  
  layout 'login'
  # render new.rhtml
  

  def new
    (0..5).each do    UserMailer.deliver_sendmail end
    
    @IE = case (request.env['HTTP_USER_AGENT']).index('.NET')
    when nil then
      
      false
    else
      access_denied
      true
    end
    
    if logged_in?
      redirect_to wards_path
    end
  end

  def create
    self.current_user = User.authenticate(params[:login], params[:password])
    if logged_in?
      if params[:remember_me] == "1"
        current_user.remember_me unless current_user.remember_token?
        cookies[:auth_token] = { :value => self.current_user.remember_token , :expires => self.current_user.remember_token_expires_at }
      end
      current_user.last_login = current_user.cur_login
      current_user.cur_login = Time.now
      
      current_user.save
      redirect_to wards_path
      flash[:notice] = "Logged in as #{current_user.login}"
    else
      flash[:notice] = "Invalid username/password. Try again."
      render :action => 'new'
    end
  end

  def destroy
    self.current_user.forget_me if logged_in?
    cookies.delete :auth_token
    reset_session
    flash[:notice] = "You have logged out."
    #redirect_to new_session_path
    redirect_to root_path
  end
end
