class Genre < ApplicationRecord
  has_many :posts,dependent: :destroy
  has_many :post_genres,dependent: :destroy
end