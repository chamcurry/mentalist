class Post < ApplicationRecord
  belongs_to :menber
  has_many :comments,dependent: :destroy
  has_many :favorites,dependent: :destroy
  has_many :genres,dependent: :destroy
  has_many :post_genres,dependent: :destroy
  has_one_attached :image

  validates :title,:body,:image,:star,presence: true
  def self.search(keyword)
    where(["title like? OR body like?","%#{keyword}","%#{keyword}"])
  end
end