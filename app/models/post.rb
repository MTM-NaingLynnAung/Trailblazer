class Post < ApplicationRecord
  belongs_to :user, foreign_key: 'user_id'
  has_many :post_attachments, :dependent => :destroy
end
