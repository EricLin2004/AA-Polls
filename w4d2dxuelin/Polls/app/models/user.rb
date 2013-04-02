class User < ActiveRecord::Base
  validates :name, :presence => true
  has_many :polls, :responses
  belongs_to :team
end