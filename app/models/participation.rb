class Participation < ActiveRecord::Base
   belongs_to :user
   belongs_to :ground
   has_one :position
   has_one :team
   
   validates :user_id, :presence => true
   validates :ground_id, :presence => true
   # validates_inclusion_of :position, :in => ["forward", "midfield","back","keeper"]
   # validates_inclusion_of :team, :in => ["a", "b"]
   validates_uniqueness_of :user_id, :scope => [:ground_id]

end
