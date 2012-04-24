class Kit < ActiveRecord::Base
  attr_accessible :content, :kitable_id, :kitable_type

  validates :content, :presence => true, :length => { :maximum => 3000 }
  validates :user_id, :presence => true
  validates :kitable_id, :presence => true 
  validates :kitable_type, :presence => true
  validates_inclusion_of :kitable_type, :in => ["Ground"]

  belongs_to :user
  belongs_to :kitable, :polymorphic => true
  
  default_scope :order => 'kits.updated_at DESC'
end
