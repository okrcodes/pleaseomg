class Shot < ApplicationRecord
  belongs_to :user
  mount_uploader :image_shot, UserShotUploader
end
