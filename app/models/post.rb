class Post < ApplicationRecord

  has_one_attached :image

  has_many :comments
  has_many :favorites
  # belongs_to :menber

  def self.search(keyword)
    where(["title like? OR body like?","%#{keyword}","%#{keyword}"])
  end
end