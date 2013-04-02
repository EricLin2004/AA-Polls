class Choice < ActiveRecord::Base
  validates :creator_id, :title, :presence => true
  belongs_to :question
end