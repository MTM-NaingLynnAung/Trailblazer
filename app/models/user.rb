class User < ApplicationRecord
  has_secure_password
  has_many :posts, :dependent => :destroy
  mount_uploader :image, ImageUploader
  # has_one_attached :image
end
