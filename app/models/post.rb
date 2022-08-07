class Post < ApplicationRecord
  belongs_to :menber
  has_many :post_genres,dependent: :destroy
  has_many :genres,through: :post_genres,dependent: :destroy
  has_many :comments,dependent: :destroy
  has_many :favorites,dependent: :destroy
  has_one_attached :image
  validates :title,:body,:image,:star,presence: true

  def self.search(keyword)
    if search
      # titleまたはbodyカラムに前方一致している文字列を検索する
      where(["title like?","%#{keyword}"])
    else
      all
    end
  end
end