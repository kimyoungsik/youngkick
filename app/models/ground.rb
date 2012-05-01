class Ground < ActiveRecord::Base
  validates_presence_of :user_id, :title, :location, :datetime, :forwardcount, :midfieldcount , :backcount , :keepercount, :limit, :limitday
  
  # has_attached_file :photo
   attr_accessible  :user_id, :title, :location, :datetime, :forwardcount, :midfieldcount , :backcount , :keepercount, :limit, :status, :description, :winner, :score, :limitday, :photo
   
  has_many :photos, :as => :photoable, :dependent => :destroy
  # accepts_nested_attributes_for :photos, :allow_destroy => true  
  has_attached_file :photo 
  belongs_to :user
  
  has_many :kits, :as => :kitable, :dependent => :destroy
  has_many :participations, :dependent => :destroy
  has_many :participants, :through => :participations, :source => :user
  
  
  default_scope :order => 'grounds.datetime'
  
  validates_inclusion_of :status, :in => ["pending", "progress","before","cancel","after"]
  
  # validates_inclusion_of :winner, :in => ["a", "b","tie"]
  # 기본을 nil로 잡아버리고
  def profile_photo
    photos.first
  end
 
  
end
