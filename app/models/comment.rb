class Comment < ApplicationRecord
  belongs_to :menber
  belongs_to :post
  validates :post_comment,presence: true
end
