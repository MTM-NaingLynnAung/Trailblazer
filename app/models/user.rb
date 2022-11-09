class User < ApplicationRecord
  include ImageUploader::Attachment(:image)
  has_secure_password
  has_many :posts, :dependent => :destroy
  has_one_attached :image
  has_secure_token :auth_token, length: 36

  validates :name, presence: true, length: { maximum: 100 }
  validates :email, presence: true, length: { maximum: 100 },
                    format: { with: Constants::VAILD_EMAIL_REGEX }, uniqueness: true
  validates :phone, numericality: true, allow_blank: true, format: { with: Constants::VAILD_PHONE_REGEX }, length: { maximum: 12 }
  validates :address, allow_blank: true, length: { maximum: 255 }
end
