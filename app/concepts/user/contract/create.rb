require 'reform/form/validation/unique_validator'
module User::Contract
  class Create < Reform::Form
    include Sync::SkipUnchanged
    include ImageUploader::Attachment(:image)
    property :name
    property :email
    property :password
    property :password_confirmation, virtual: true
    property :phone
    property :user_type
    property :address
    property :dob
    property :image
    property :image_data

    validates :name, presence: true, length: { maximum: 100 }
    validates :email, presence: true, length: { maximum: 100 },
                      format: { with: Constants::VAILD_EMAIL_REGEX },
                      unique: true
    validates :password, presence: true, confirmation: true
    validates :password_confirmation, presence: true
    validates :phone, numericality: true, allow_blank: true, length: { maximum: 13 }
    validates :address, allow_blank: true, length: { maximum: 255 }
    validates :image, file_size: {less_than: 2.megabytes},
                      file_content_type: {allow: ['image/jpeg', 'image/png', 'image/webp']}
  end
end
