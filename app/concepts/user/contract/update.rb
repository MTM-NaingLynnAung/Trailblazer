require 'reform/form/validation/unique_validator'
module User::Contract
  class Update < Reform::Form
    property :name
    property :email
    property :phone
    property :address
    property :dob
    property :user_type
    property :image

    validates :name, presence: true, length: { maximum: 100 }
    validates :email, presence: true, length: { maximum: 100 },
                      format: { with: /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i },
                      unique: true
    validates :phone, numericality: true, allow_blank: true, length: { maximum: 13 }
    validates :address, allow_blank: true, length: { maximum: 255 }
  end
end
