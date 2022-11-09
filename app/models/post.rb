class Post < ApplicationRecord
  belongs_to :user, foreign_key: 'user_id'
  has_many :post_attachments, :dependent => :destroy

  validates :title, presence: true, length: { maximum: 30 }
  validates :description, presence: true
  validates :privacy, presence: true
end
