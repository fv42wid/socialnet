class Like < ActiveRecord::Base
  belongs_to :likable, polymorphic: true
end
