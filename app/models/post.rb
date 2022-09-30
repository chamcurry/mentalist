class Post < ApplicationRecord
  belongs_to :member
  has_many :post_genres,dependent: :destroy
  has_many :genres,through: :post_genres,dependent: :destroy
  has_many :favorites,dependent: :destroy
  has_many :comments,dependent: :destroy
  # default_scope -> { reorder(creaated_at: :desc) }
  has_one_attached :image
  validates :title,:body,:image,:star,presence: true

  def favorited_by?(menber)
  # favoritesテーブルに存在するか判断
    favorites.exists?(menber_id: menber.id)
  end

end
