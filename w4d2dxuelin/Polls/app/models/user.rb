class User < ActiveRecord::Base
  validates :name, :presence => true
  has_many :polls, :foreign_key => :creator_id
  #SELECT *
  #FROM polls
  #WHERE polls.creator_id = self.id

  has_many :responses, :foreign_key => :voter_id
  #SELECT *
  #FROM responses
  #WHERE responses.voter_id = self.id

  belongs_to :team
  #SELECT *
  #FROM team
  #WHERE team.id = self.team_id

  has_many :poll_histories, :foreign_key => :voter_id

  attr_accessible :name, :team_id
  def create_poll(title)
    Poll.create(:title => title, :creator_id => self.id)
  end

  def answer_question(choice_id)
    Response.create(:voter_id => self.id,
                    :choice_id => choice_id)
  end

  def history
    self.responses.joins(:choice).group(:choice_id, :question_id).count
  end

  def join_team(team_id)
    self.team_id = team_id
  end
end