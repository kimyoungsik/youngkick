class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable
  attr_accessor :avatar_url 
  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :first_name, :last_name, :birthday, :gender, :facebook_uid, :facebook_token, :point ,:record, :win, :loss, :tie,:forwardpoint, :midfieldpoint, :backpoint, :keeperpoint, :level
  
  has_many :grounds, :dependent => :destroy
  has_many :participations, :dependent => :destroy
  has_many :recordbooks, :dependent => :destroy
  has_many :authored_kits, :class_name => "Kit", :dependent => :destroy
  has_many :photos, :as => :photoable, :dependent => :destroy
  has_many :authored_photos, :class_name => "Photo", :dependent => :destroy
  
  default_scope :order => 'users.point DESC'
  
  
  has_attached_file :avatar, 
                    :default_url => :facebook_profile_photo, 
                    :processors => [:cropper],
                    :styles => {
                      :thumb => "50x50#",
                      :small => "100x100#"}
                      
                      
  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["user_hash"]
        user.email = data["email"]
      end
    end
  end
  
  def self.find_for_facebook_oauth(access_token, signed_in_resource=nil)

    data = access_token.extra.raw_info
    if user = User.find_by_email(data.email)
      user
    else # Create a user with a stub password. 
      User.create!(:email => data.email, 
                    :first_name => data.first_name, 
                    :last_name => data.last_name, 
                    :birthday => Date::strptime(data.birthday, "%m/%d/%Y"),
                    :gender => data.gender,
                    :facebook_uid => data.id,
                    :facebook_token => access_token.credentials.token,
                    :password => Devise.friendly_token[0,20]) 
    end
  end
  def korean_full_name
    last_name + first_name
  end
  
  def full_name
    first_name + " " + last_name
  end
  
  def facebook_profile_photo
    if self.facebook_uid?
      "http://graph.facebook.com/#{self.facebook_uid}/picture?type=square"
    else 
      "/assets/default_profile.png"
    end
  end
  
  def profile_photo
    photos.first
  end
  
  def participates_in?(ground)
    Participation.where(:user_id => self.id, :ground_id => ground.id).any?
  end
  
end
