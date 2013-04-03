class Question < ActiveRecord::Base
  validates :body, :poll_id, :presence => true
  belongs_to :poll
  #SELECT *
  #FROM polls
  #WHERE polls.id = self.poll_id
  has_many :choices
  #SELECT *
  #FROM choices
  #WHERE choices.question_id = self.id
  has_many :responses, :through => :choices
  #SELECT responses.*
  #FROM responses
  #JOIN choices
  #ON responses.choice_id = choices.id
  #WHERE choices.question_id = self.id
  attr_accessible :body, :poll_id

  def add_choice(answer)
    Choice.create(:question_id => self.id,
                  :answer => answer)
  end
end