class Response < ActiveRecord::Base
  validates :voter_id, :choice_id, :presence => true
  belongs_to :user, :foreign_key => "voter_id"
  belongs_to :choice
  belongs_to :question, :through => :choices
end