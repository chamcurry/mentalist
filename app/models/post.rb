class Post < ApplicationRecord
  belongs_to :menber
  has_many :post_genres,dependent: :destroy
  has_many :genres,through: :post_genres,depndent: :destroy
  has_many :comments,dependent: :destroy
  has_many :favorites,dependent: :destroy
  has_one_attached :image
  validates :title,:body,:image,:star,presence: true

  def self.search(search)
    if search
      # titleまたはbodyカラムに部分一致している文字列を検索する
      Post.where(["title like?","%#{search}%"])
    else
      Post.all
    end
  end
  # def self.search(search)
  #     key_search = Post.where(["title like?","#{search}"])
  #     genre_search = params[:genre_id].present? ? Genre.find(params[:genre_id]).posts: Post.all
  #     @submit_searh = Post.where("genre_id IN (?) or title IN (?)",key_search,genre_search)
  # end
end