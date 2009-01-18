class OasisController < ApplicationController
  before_filter :login_required
  
  def index
    $user = current_user
    @followers = Follower.find_all_by_user_id($user.id)
    
    @profiles = Array.new
    begin
      @last_login = (($user.last_login).localtime).strftime("%a %B %d, %Y %I:%M%p ")
    rescue 
      @last_login = "First Time Login!"
    end
    
    #for each ward owned, store it in variable @profiles
    @followers.each do |f|
      @profiles<<Profile.find(f.idno)
          
    end
    @menu = make_menu



   
  end

  def find_followers idno
    @ff = Follower.find_all_by_idno idno
      @ffs= Array.new
      @ff.each do |f|
        @ffs<<User.find(f.user_id)
      end
      return @ffs
  end
  
  def show_profile
    if verified_followed?
      @ffs = find_followers params[:id]
      
      @prof = Profile.find(params[:id])
      render :partial => "profile" ,:locals => { :profile => @prof , :ffs=>@ffs}
    else
      render :text => "You are not allowed to access this."
    end
  end

  def show_attendance
    if verified_followed?
      @prof = Profile.find(params[:id])
      render :partial => "profile" ,:locals => { :profile => @prof}
    else
    end
  end

  def show_violations
    if verified_followed?
      @vio = Violations.find(:all, :params =>{:idno => params[:id]})
      render :partial => "violations"
    else
    end
  end
  
  protected
  def verified_followed?
    followers = Follower.find_all_by_user_id(current_user.id)
    followers.each do |follower|
      return true if follower.idno.to_s == params[:id].to_s
    end
    return false
  end

  def make_menu
    menu = Array.new
    menu << "Profile"
    menu << "Attendance"
    menu << "Fees"
    menu << "Checklist"
    menu << "Grades"
    menu << "Guidance"
    menu << "Violations"
    return menu

  end


end
