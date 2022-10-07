require 'reform/form/validation/unique_validator'
module User::Contract
  class PasswordResetSend < Reform::Form
    property :email

    validates :email, presence: true, length: { maximum: 100 },
                      format: { with: /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i }
  end
end
