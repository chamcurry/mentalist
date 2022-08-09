class Post < ApplicationRecord
  belongs_to :menber
  has_many :post_genres,dependent: :destroy
  has_many :genres,through: :post_genres,dependent: :destroy
  has_many :comments,dependent: :destroy
  has_many :favorites,dependent: :destroy
  has_one_attached :image
  validates :title,:body,:image,:star,presence: true

  # def self.search(search)
  #   if search
  #     Post.where(["title like ?","%#{search}%"])
  #   else
  #     Post.all
  #   end
  # end
end