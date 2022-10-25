module Post::Contract
  class Update < Reform::Form
    include Sync::SkipUnchanged
    property :title
    property :description
    property :privacy
    property :user_id
    property :image, virtual: true
    validates :image, allow_blank: true, file_size: {less_than: 2.megabytes},
                                    file_content_type: {allow: ['image/jpeg', 'image/png', 'image/webp']}
    validates :title, presence: true
    validates :description, presence: true
    validates :privacy, presence: true
  end
end
