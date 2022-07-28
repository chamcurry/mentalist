class Post < ApplicationRecord
  belongs_to :menber
  has_many :comments,dependent: :destroy
  has_many :favorites,dependent: :destroy
  has_one_attached :image
  def self.search(keyword)
    where(["title like? OR body like?","%#{keyword}","%#{keyword}"])
  end
end