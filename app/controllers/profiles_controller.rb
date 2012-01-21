class ProfilesController < ApplicationController
  skip_before_filter :check_profile, :except => [:edit]
  
  def edit
    @user = current_user
  end
  
  def setup
    @user = current_user
    @profile = current_user.profile
    
    @profile.valid?
  end

  def update
    @user = current_user
    @profile = current_user.profile
    
    # If it's not valid in the first place, they're a new user
    # If the profile update fails, we want to show them the setup page again
    new_user_setup = !@profile.valid?

    respond_to do |format|
      if @profile.update_attributes(params[:profile])
        format.html { redirect_to dashboard_path, :notice => 'Profile successfully updated!' }
      else
        if new_user_setup
          format.html { render :action => "setup" }
        else
          format.html { render :action => "edit" }
        end
      end
    end
  end
end
