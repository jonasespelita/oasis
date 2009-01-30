class AdminController < ApplicationController
	before_filter :authorize, :except => :login

	def index
		@campus_activities = CampusActivities.find(:all)
		@announcements = Announcements.find(:all)
		@admins = Admin.find(:all)
		@queries = Query.find(:all)
		@users = User.find(:all)
		admin = Admin.find(session[:admin_id])
		if admin.position == 'oa'
					@is_oa = true
  		else
					@is_oa = false
		end
	end

  def oa
  	@admins = Admin.find(:all)
  	admin = Admin.find(session[:admin_id])
		if admin.position != 'oa'
			redirect_to(:action => "index")
		end
  
  end
  
  def login
  	session[:admin_id] = nil
  	if request.post?
  		admin = Admin.authenticate(params[:name], params[:password])
  		if admin && admin.active == true
			session[:admin_id] = admin.id
			admin.last_visit = Time.now
			admin.save
			redirect_to(:action => "index")
  		elsif admin.active == false
  			flash.now[:notice] = "Your account has been disabled"
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
  
  	def delete_activity
	  	deleted_activity = CampusActivities.find(params[:delete_activity_id])
	  	unless deleted_activity.destroy
	  		redirect_to(:action => "index")
	  		flash[:notice] = "not deleted"
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
	
	def add_admin
		new_admin = Admin.new
		new_admin.first_name = params[:add_admin_first_name]
		new_admin.last_name = params[:add_admin_last_name]
		new_admin.position = params[:add_admin_position]
		new_admin.username = params[:add_admin_username]
		new_admin.email = params[:add_admin_email]
		new_admin.active = true
		new_admin.create_password(params[:add_admin_password])
		unless new_admin.save
  			redirect_to(:action => "index")
  		flash[:notice] = "not saved"
  		end
  		redirect_to(:action => "index")
	end
	
	def edit_admin
  		unless params[:edit_admin_id].blank?
			edit_admin = Admin.find(params[:edit_admin_id])
			edit_admin.first_name = params[:edit_admin_first_name]
			edit_admin.last_name = params[:edit_admin_last_name]
			edit_admin.position = params[:edit_admin_position]
			edit_admin.username = params[:edit_admin_username]
			edit_admin.email = params[:edit_admin_email]
			unless params[:edit_admin_password].blank?
				edit_admin.create_password(params[:edit_admin_password])
			end
			unless edit_admin.save
	  		redirect_to(:action => "index")
	  		flash[:notice] = "not saved"
	  		end
	  		
  		else
			redirect_to(:action => "index")
			flash[:notice] = "Please select an admin to be edited"
		end
		redirect_to(:action => "index")
	end
	
	def enable_admin
		unless params[:enable_admin_id].blank?
			enable_admin = Admin.find(params[:enable_admin_id])
			enable_admin.active = true
			unless enable_admin.save
	  		redirect_to(:action => "index")
	  		flash[:notice] = "not saved"
	  		end
	  		redirect_to(:action => "index")
	  	else
	  		redirect_to(:action => "index")
			flash[:notice] = "Please select an admin"
		end
		
	end
	
	def disable_admin
		unless params[:disable_admin_id].blank?
			disable_admin = Admin.find(params[:disable_admin_id])
			disable_admin.active = false
			unless disable_admin.save
	  		redirect_to(:action => "index")
	  		flash[:notice] = "not saved"
	  		end
	  		redirect_to(:action => "index")
	  	else
	  		redirect_to(:action => "index")
			flash[:notice] = "Please select an admin"
		end
		
	end
	
	def delete_query
		deleted_query = Query.find(params[:delete_user_query_id])
		unless deleted_query.destroy
	  		redirect_to(:action => "index")
	  		flash[:notice] = "not deleted"
	  	end
		redirect_to(:action => "index")
	end
	
	def resolve_query
		resolved_query = Query.find(params[:resolve_user_query_id])
		if resolved_query.resolved
			resolved_query.resolved = false
		else
			resolved_query.resolved = true
		end
		resolved_query.save
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
