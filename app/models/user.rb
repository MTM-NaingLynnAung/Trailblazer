class User < ApplicationRecord
  has_secure_password
  has_many :posts, :dependent => :destroy
  include ImageUploader::Attachment(:image)
end
