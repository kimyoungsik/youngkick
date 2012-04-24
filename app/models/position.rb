class Position < ActiveRecord::Base
  belongs_to :participation
  belongs_to :ground#없어도 될듯
  # belongs_to :recordbook

end
