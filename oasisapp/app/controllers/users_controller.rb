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
    render :action => "new"
  end
  
  def finish
    
  end
  def change_password
    @user = current_user
    @old = params[:old_password]

    @lang = case current_user.lang_pref
    when 1
     "<option selected='selected'>English</option> <option>Filipino</option>"
    when 2
      "<option>English</option> <option selected='selected'>Filipino</option>"
    end

    @checkemail = current_user.email_pref
    @checkcp = current_user.mobile_pref

  end


  #
  # Change user passowrd
  def change_password_update
    if User.authenticate(current_user.login, params[:old_password])
      if ((params[:password] == params[:password_confirmation]) && !params[:password_confirmation].blank?)
        current_user.password_confirmation = params[:password_confirmation]
        current_user.password = params[:password]

        if current_user.save!
          flash[:notice] = "Password successfully updated"
          redirect_to change_password_path
        else
          flash[:alert] = "Password not changed"
          render :action => 'change_password'
        end

      else
        flash[:alert] = "New Password mismatch"
        render :action => 'change_password'
      end
    else
      flash[:alert] = "Old password incorrect"
      render :action => 'change_password'
    end
  end

  def change_email
    current_user.email = params[:email]

    current_user.cp_number = params[:cp]
    current_user.lang_pref = 2
    current_user.mobile_pref = params[:val2]
    current_user.email_pref = params[:val1]
#      case params[:lang]
#    when "English"
#      1
#    when "Filipino"
#      2
#    end
    
    if current_user.save
      flash[:e_alert] = "Settings successfully updated}"

    else
      flash[:alert] = "Invalid Email"
      render :action => 'change_password'
    end
  end


  def show
    
  end

  def vlogin

      if "#{params[:login]}".length==0
         render :text => "Your desired username."
         return
      end
      
    if(User.find_by_login params[:login]  )
   
      render :text => "Username has already been taken"
        
      else
     
 
      render :text =>"Ok!"
    end
  end

  def vpassword
    if("#{params[:password]}".length >=6)
      session[:password] = params[:password]
      render :text => "Ok!"
    else
      render :text => "Use 6 to 32 characters, no spaces."
    end

  end

  def vconfirm_password

    if params[:confirm_password]== session[:password]
      render :text => "Ok!"
    else
      render :text => "Passwords don't match!"
    end
  end

  def vemail
    if params[:email] =~ /(.+)@(.+)\.(.{3})/
      if !User.find_by_email(params[:email])
      render :text => "Ok!"
      else
        render :text => "Email has already been registered. Choose another."
      end

     else
       render :text => "Invalid Email address."
     end



  end


end
