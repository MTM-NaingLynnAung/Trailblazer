class PostAttachment < ApplicationRecord
  mount_uploader :image, PostImageUploader
  belongs_to :post
  validates :image, presence: false
end
