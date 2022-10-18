class User < ApplicationRecord
  include ImageUploader::Attachment(:image)
  has_secure_password
  has_many :posts, :dependent => :destroy
end
