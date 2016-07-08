class Friendship < ActiveRecord::Base
  belongs_to :user
  has_many :user, through: :notifications
end
