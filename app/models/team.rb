class Team < ActiveRecord::Base
  belongs_to :participation
  belongs_to :ground
  
end
