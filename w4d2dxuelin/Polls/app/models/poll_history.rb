class PollHistory < ActiveRecord::Base
  validates_with PollHistoryValidator
  belongs_to :user
  belongs_to :poll

  attr_accessible :voter_id, :poll_id
end