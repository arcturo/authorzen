class ApplicationController < ActionController::Base
  protect_from_forgery
  
  before_filter :check_profile
  
  helper_method :current_user
  
  private
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  
  def check_profile
    if current_user && !current_user.profile.valid?
      redirect_to setup_profile_path
    end
  end
end
