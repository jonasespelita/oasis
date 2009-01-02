class OasisController < ApplicationController
  before_filter :login_required
  def index
    @user = current_user
    @followers = Follower.find_all_by_user_id(@user.id)
    @profiles = Array.new

    #for each ward owned store it in variable @profiles
    @followers.each do |f|
      @profiles<<Profile.find(f.idno)
    end
      
    

  end

end
