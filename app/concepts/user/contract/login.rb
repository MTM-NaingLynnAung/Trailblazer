module User::Contract
  class Login < Reform::Form
    property :email
    property :password

    validates :email, presence: { :message => "can not be blank." }, format: { with: Constants::VAILD_EMAIL_REGEX }
    validates :password, presence: true
  end
end
