class User < ApplicationRecord
  include ImageUploader::Attachment(:image)
  has_secure_password
  has_many :posts, :dependent => :destroy
  has_one_attached :image
  has_secure_token :auth_token, length: 36
end
