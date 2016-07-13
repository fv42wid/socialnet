class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :posts, :dependent => :destroy
  has_many :friendships
  has_many :notifications, foreign_key: :recipient_id
  has_many :likes
  has_many :events
  has_many :pictures

  def likes?(post)
    post.likes.where(user_id: id).any?
  end

  def friends
    User.where(id: self.friendships.select("friend_id"))
  end
  
end
