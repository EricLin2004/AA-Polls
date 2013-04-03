class Response < ActiveRecord::Base
  validates :voter_id, :choice_id, :presence => true
  belongs_to :user
  #SELECT *
  #FROM users
  #WHERE users.id = self.voter_id
  belongs_to :choice
  #SELECT *
  #FROM choices
  #WHERE choices.id = self.choice_id
  attr_accessible :voter_id, :choice_id

end