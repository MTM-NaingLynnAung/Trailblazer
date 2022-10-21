class Post < ApplicationRecord
  belongs_to :user, foreign_key: 'user_id'
  has_many :post_attachments, :dependent => :destroy
  accepts_nested_attributes_for :post_attachments, reject_if: proc { |attributes| attributes['image'].blank? }
end
