class Genre < ApplicationRecord
  belongs_to :post
  has_many :post_genres,dependent: :destroy
end
