class Post < ActiveRecord::Base
  belongs_to :user
  validates :body, :user_id, :presence => true
  has_many :likes
end
