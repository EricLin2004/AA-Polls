class Poll < ActiveRecord::Base
  validates :title, :creator_id, :presence => true
  belongs_to :user, :foreign_key => "creator_id"
  has_many :choices
end