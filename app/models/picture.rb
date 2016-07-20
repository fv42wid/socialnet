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
end
