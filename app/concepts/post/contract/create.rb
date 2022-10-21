module Post::Contract
  class Create < Reform::Form
    property :title
    property :description
    property :privacy
    property :user_id
    collection :post_attachments, populate_if_empty: PostAttachment do 
      property :image, skip_if: lambda { |fragment, *| fragment['image'].blank? }

      validate :image

      def image
        return false if post_attachments.nil?
      end
    end

    validates :title, presence: true
    validates :description, presence: true
    validates :privacy, presence: true

  end
end
