class AdminController < ApplicationController
	before_filter :authorize, :except => :login
	

	def index
		@campus_activities = CampusActivities.find(:all)
		@announcements = Announcements.find(:all)
		admin = Admin.find(session[:admin_id])
		if admin.position == 'oa'
			redirect_to(:action => "oa")
		end
	end

  def oa
  	admin = Admin.find(session[:admin_id])
		if admin.position != 'oa'
			redirect_to(:action => "index")
		end
  
  end
  
  def login
  	session[:admin_id] = nil
  	if request.post?
  		admin = Admin.authenticate(params[:name], params[:password])
  		if admin
  			if admin.position == 'oa'
					session[:admin_id] = admin.id
					redirect_to(:action => "oa")
  			else
					session[:admin_id] = admin.id
					redirect_to(:action => "index")
				end
  		else
  			flash.now[:notice] = "Invalid user/password combination"
  		end
  	end
  
  end
  
  
  def settings
  	unless params[:new_password].blank?
			if request.post?
				admin = Admin.authenticate(Admin.find(session[:admin_id]).username, params[:current_password])
				if params[:new_password] == params[:confirm_password]
					admin.create_password(params[:new_password])
					admin.save
					redirect_to(:action => "index")
					flash[:notice] = "password changed"
				else
					flash.now[:notice] = "new password did not match"
				end
			end
		end
  
  end
  
  def logout
		session[:admin_id] = nil
		redirect_to(:action => "login" )
		flash[:notice] = "Logged out"
  end
  
  def edit_activity
  	unless params[:edit_activity_id].blank?
			edited_activity = CampusActivities.find(params[:edit_activity_id])
			edited_activity.date = params[:edit_activity_date]
			edited_activity.activity = params[:edit_activity_name]
			edited_activity.summary = params[:edit_activity_summary]
			unless edited_activity.save
				redirect_to(:action => "index")
				flash[:notice] = "not saved"
			end
			redirect_to(:action => "index")
		else
			redirect_to(:action => "index")
			flash[:notice] = "Please select an activity to be edited"
		end 
  end
  
  def add_activity
  	new_activity = CampusActivities.new
  	new_activity.date = params[:add_activity_date]
  	new_activity.activity = params[:add_activity_name]
  	new_activity.summary = params[:add_activity_summary]
  	unless new_activity.save
  		redirect_to(:action => "index")
  		flash[:notice] = "not saved"
  	end
  	redirect_to(:action => "index")
  end
  
  def edit_announcement
		unless params[:edit_announcement_id].blank?
			edited_announcement = Announcements.find(params[:edit_announcement_id])
			edited_announcement.date_time = params[:edit_announcement_date]
			edited_announcement.announcement = params[:edit_announcement_name]
			edited_announcement.summary = params[:edit_announcement_summary]
			unless edited_announcement.save
				redirect_to(:action => "index")
				flash.now[:notice] = "not saved"
			end
			redirect_to(:action => "index")
		else
			redirect_to(:action => "index")
			flash[:notice] = "Please select an announcement to be edited"
		end 
  end
  
  def add_announcement
  	new_announcement = Announcements.new
  	new_announcement.date_time = params[:add_announcement_date]
  	new_announcement.announcement = params[:add_announcement_name]
  	new_announcement.summary = params[:add_announcement_summary]
  	unless new_announcement.save
  		redirect_to(:action => "index")
  		flash[:notice] = "not saved"
  	end
  	redirect_to(:action => "index")
  end
  
  def delete_announcement
  	deleted_announcement = Announcements.find(params[:delete_announcement_id])
  	unless deleted_announcement.destroy
  		redirect_to(:action => "index")
  		flash[:notice] = "not deleted"
  	end
  	redirect_to(:action => "index")
  	
	end
  
  protected
  	def authorize
  		unless Admin.find_by_id(session[:admin_id])
  			flash[:notice] = "Please log in"
  			redirect_to :action => :login
  		end
  	end	
end
