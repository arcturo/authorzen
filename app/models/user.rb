class User < ActiveRecord::Base
  has_one :profile

  # This issue was supposed to be fixed by now, but isn't:
  #   https://github.com/radar/forem/issues/88
  # So I still have to include this here to get the default
  # User permissions settings pulled in from this module.
  include Forem::DefaultPermissions

  delegate :name, :email, :bio, :username, :url, :to => :profile
  
  def self.create_with_omniauth(auth)
    user = self.new
    
    user.provider = auth["provider"]
    user.uid = auth["uid"]
    
    user.profile = Profile.build_from_data(auth)
    
    user
  end
end
