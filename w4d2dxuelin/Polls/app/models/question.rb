class Question < ActiveRecord::Base
  validates :body, :choice_id, :poll_id, :presence => true
  belongs_to :poll
  belongs_to :user, :through => :polls
  has_many :choices
  has_many :responses, :through => :choices
end