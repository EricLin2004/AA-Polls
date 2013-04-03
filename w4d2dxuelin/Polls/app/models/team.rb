class Team < ActiveRecord::Base
  validates :name, :presence => true
  has_many :users
  #SELECT *
  #FROM users
  #WHERE users.team_id = self.id
  attr_accessible :name

end