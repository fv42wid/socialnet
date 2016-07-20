class Post < ActiveRecord::Base
  belongs_to :user
  validates :body, :user_id, :presence => true
  has_many :likes, :as => :likable

  def mentions
    @mentions ||= begin
                    regex = /@([\w]+\@[\w]+\.[\w]+)/
                    body.scan(regex).flatten
                  end
  end

  def mentioned_users
    @mentioned_users ||= User.where(email: mentions)
  end

  def notify_mentioned_users
    mentioned_users.each do |user|
      Notification.create(recipient: user, actor_id: self.user_id, action: "tagged", notifiable: self)
    end
  end

end
