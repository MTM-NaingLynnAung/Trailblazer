class PostAttachment < ApplicationRecord
  mount_uploader :image, PostImageUploader
  belongs_to :post
end
