class Kit < ActiveRecord::Base
  attr_accessible :content, :kitable_id, :kitable_type, :photos_attributes
  has_many :photos, :as => :photoable, :dependent => :destroy

  validates :content, :presence => true, :length => { :maximum => 3000 }
  validates :user_id, :presence => true
  validates :kitable_id, :presence => true 
  validates :kitable_type, :presence => true
  validates_inclusion_of :kitable_type, :in => ["Ground"]

  belongs_to :user
  belongs_to :kitable, :polymorphic => true
  
  default_scope :order => 'kits.updated_at DESC'
  accepts_nested_attributes_for :photos, :allow_destroy => true      
end
