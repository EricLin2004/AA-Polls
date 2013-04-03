class Poll < ActiveRecord::Base
  validates :title, :creator_id, :presence => true
  belongs_to :user, :foreign_key => :creator_id
  #SELECT *
  #FROM users
  #WHERE users.id = self.creator_id

  has_many :questions
  #SELECT *
  #FROM questions
  #WHERE questions.poll_id = self.id

  has_many :choices, :through => :questions
  #SELECT choices.*
  #FROM choices
  #JOIN questions
  #ON choices.question_id = questions.id
  #WHERE questions.poll_id = self.id

  has_many :poll_histories

  attr_accessible :creator_id, :title

  def add_question(body)
    Question.create(:poll_id => self.id,
                    :body => body)
  end

  def results
    self.questions.joins(:responses).group(:choice_id, :question_id).count
  end
end