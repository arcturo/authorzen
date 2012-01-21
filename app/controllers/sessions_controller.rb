class SessionsController < ApplicationController
  skip_before_filter :check_profile
  
  def create
    begin
    auth = request.env["omniauth.auth"]
    user = User.find_by_provider_and_uid(auth["provider"], auth["uid"])
    
    if user 
      session[:user_id] = user.id
      redirect_to root_url, :notice => "Signed in!"
    else
      @user = User.create_with_omniauth(auth)

      @user.save(:validate => false)
      @user.profile.save(:validate => false)

      session[:user_id] = @user.id
      
      if @user.profile.valid?
        redirect_to root_url, :notice => "Signed in!"
      else
        redirect_to setup_profile_path
      end
    end
  rescue Exception => e
    puts "\n" * 9
    puts e.message
    puts e.backtrace
    puts "\n" * 9
  end
  end
  
  def destroy
    session[:user_id] = nil
    redirect_to root_url, :notice => "Signed out!"
  end
end
