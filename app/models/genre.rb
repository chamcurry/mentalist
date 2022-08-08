class Genre < ApplicationRecord
  has_many :post_genres,dependent: :destroy
  has_many :posts,through: :post_genres,dependent: :destroy

  def self.genre_search(search)
    if search
      Genre.where(["soup like?","%#{search}%"])
    else
      Post.all
    end
  end
end