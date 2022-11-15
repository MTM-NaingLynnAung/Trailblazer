class History < ApplicationRecord
  belongs_to :post, foreign_key: 'post_id'
  scope :desc, -> {
    order("updated_at DESC")
  }
end
