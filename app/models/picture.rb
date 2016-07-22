class Picture < ActiveRecord::Base
  belongs_to :user
  belongs_to :album
  has_many :likes, :as => :likable

  def save_file(tempfile)
    filename = "#{self.id.to_s}.jpg"
    folder = "#{Rails.root}/public/uploads/users/#{self.user_id}"
    
    FileUtils::mkdir_p folder

    f = File.open File.join(folder, filename), "wb"
    f.write tempfile.read()
    f.close

    update location: "/uploads/users/#{self.user_id}/#{filename}"
  end

  def mentions
    @mentions ||= begin
                    regex = /@([\w]+\@[\w]+\.[\w]+)/
                    caption.scan(regex).flatten
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
