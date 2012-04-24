class Recordbook < ActiveRecord::Base
  belongs_to :user
  
  # has_one :position
  attr_accessible :win, :loss, :tie,:forwardpoint, :midfieldpoint, :backpoint, :keeperpoint, :score, :ground_id, :user_id , :position_id
    
  validates_uniqueness_of :user_id, :scope => [:ground_id, :position_id]

end
