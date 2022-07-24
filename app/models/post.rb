class Post < ApplicationRecord

  has_one_attached :image
  has_many :comments
  has_many :favorites
  belongs_to :menber
end