module Post::Contract
  class Update < Reform::Form
    include Sync::SkipUnchanged
    property :title
    property :description
    property :privacy
    property :user_id
    property :images

    validates :title, presence: true
    validates :description, presence: true
    validates :privacy, presence: true
    validates :images, file_size: {less_than: 2.megabytes},
                      file_content_type: {allow: ['image/jpeg', 'image/png', 'image/webp']}
    validate :validate_images

    def validate_images
      return if images.count <= 4 
      errors.add(:images, 'can accept max 4 images')
    end
  end
end
