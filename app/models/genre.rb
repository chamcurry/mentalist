class Genre < ApplicationRecord
  has_many :post_genres,dependent: :destroy
  has_many :posts,through: :post_genres,dependent: :destroy

  # def self.search(search)
  #   if search
  #     genre= Genre.where(soup: search)
  #     genre[0].submits
  #   else
  #     Post.all
  #   end
  # end
end