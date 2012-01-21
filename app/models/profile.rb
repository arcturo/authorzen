class Profile < ActiveRecord::Base
  belongs_to :user

  validates_presence_of :email, :message => "E-mail is required! (We don't spam you, pinky swear.)"
  validates_presence_of :name, :message => "We need your name (or alias), please."
  validates_presence_of :username, :message => "We just need a username or alias."
  validates_uniqueness_of :email, :message => "Looks like there's already an account with this e-mail!"
  validates_uniqueness_of :username, :message => "Rats!  Someone already claimed that username.  Choose another."

  def self.build_from_data(auth)
    profile = self.new
    
    profile.name = auth["info"]["name"]
    profile.url = auth["info"]["urls"]["Website"] || auth["info"]["urls"]["Blog"]
    profile.bio = auth["info"]["description"]
    profile.username = auth["info"]["nickname"]
    
    profile
  end
end
