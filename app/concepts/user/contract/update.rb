require 'reform/form/validation/unique_validator'
module User::Contract
  class Update < Reform::Form
    include Sync::SkipUnchanged
    include ImageUploader::Attachment(:image)
    property :name
    property :email
    property :phone
    property :address
    property :dob
    property :user_type
    property :image
    property :image_data

    validates :name, presence: true, length: { maximum: 100 }
    validates :email, presence: true, length: { maximum: 100 },
                      format: { with: Constants::VAILD_EMAIL_REGEX },
                      unique: true
    validates :phone, numericality: { :message => 'must be number' }, allow_blank: true, format: { with: Constants::VAILD_PHONE_REGEX, :message => "is invalid.. Eg- 09123456789" }
    validates :address, allow_blank: true, length: { maximum: 255 }
    validates :image, file_size: {less_than: 2.megabytes},
                      file_content_type: {allow: ['image/jpeg', 'image/png', 'image/webp']}
  end
end
