module Post::Contract
  class Update < Reform::Form
    include Sync::SkipUnchanged
    property :title
    property :description
    property :privacy
    property :user_id
    property :post_attachments

    validates :title, presence: true
    validates :description, presence: true
    validates :privacy, presence: true
  end
end
