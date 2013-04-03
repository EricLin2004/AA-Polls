class Choice < ActiveRecord::Base
  validates :question_id, :answer, :presence => true
  belongs_to :question
  has_many :responses
  #SELECT *
  #FROM questions
  #WHERE questions.id = self.question_id
  attr_accessible :question_id, :answer
end