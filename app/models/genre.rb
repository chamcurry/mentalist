class Genre < ApplicationRecord
  has_many :posts,through: :post_genres,dependent: :destroy
  has_many :post_genres,dependent: :destroy
end