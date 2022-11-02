module Post::Contract
  class Create < Reform::Form
    property :title
    property :description
    property :privacy
    property :user_id
    property :image, virtual: true

    validates :title, presence: true, length: { maximum: 30 }
    validates :description, presence: true
    validates :privacy, presence: true
    validates :image, presence: true ,file_size: {less_than: 2.megabytes},
                                      file_content_type: {allow: ['image/jpeg', 'image/png', 'image/webp']}
    validate :image_limit

    def image_limit
      if image.present?
        errors.add(:image, "can't accept more than 4 images") if image.length > 4
      end
    end
  end
end
