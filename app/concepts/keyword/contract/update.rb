require 'reform/form/validation/unique_validator'
module Keyword::Contract
  class Update < Reform::Form
    property :name

    validates :name, presence: true, length: { maximum: 50 }, unique: true
  end
end
