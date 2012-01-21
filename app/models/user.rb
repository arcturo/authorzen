class User < ActiveRecord::Base
  has_one :profile
  
  delegate :name, :email, :bio, :username, :url, :to => :profile
  
  def self.create_with_omniauth(auth)
    user = self.new
    
    user.provider = auth["provider"]
    user.uid = auth["uid"]
    
    user.profile = Profile.build_from_data(auth)
    
    user
  end
end
