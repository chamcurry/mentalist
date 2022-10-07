class Post < ApplicationRecord
  belongs_to :member
  has_many :post_genres,dependent: :destroy
  has_many :genres,through: :post_genres,dependent: :destroy
  has_many :favorites,dependent: :destroy
  has_many :comments,dependent: :destroy
  # default_scope -> { reorder(creaated_at: :desc) }
  has_one_attached :image
  validates :title,:body,:image,:star,presence: true

  def favorited_by?(member)
  # favoritesテーブルに存在するか判断
    favorites.exists?(member_id: member.id)
  end

  def self.search(keyword,genre_id)
    if keyword.blank? && genre_id.blank?
      @posts = Post.all.order(id: "DESC")
    elsif keyword.present? && genre_id.blank?
      @posts = Post.where("title LIKE ?","%#{keyword}%")
      @posts = Kaminari.paginate_array(@posts)
    elsif keyword.blank? && genre_id.present?
      @posts = Genre.find(genre_id).posts
      @posts = Kaminari.paginate_array(@posts)
    else
      @posts = Genre.find(genre_id).posts.where("title LIKE ?","%#{keyword}%")
      @posts = Kaminari.paginate_array(@posts)
    end
  end

  def Post.like_search(keyword,genre_id)
    favorite = Favorite.where(member_id: current_member.id).order("created_at desc").pluck(:post_id)
    favorite_post = Post.find(favorite)
    #Post.joins(:favorite).where("favorites.member_id = ?",current_member.id).order("favorites.created_at desc")
    if keyword.blank? && genre_id.blank?
      @posts = Kaminari.paginate_array(favorite_post)
    elsif keyword.present? && genre_id.blank?
      favorite = favorite_post.where("title LIKE ?","%#{keyword}%")
      @posts = Kaminari.paginate_array(favorite)
    elsif keyword.blank? && genre_id.present?
      target_genre_post = Genre.find(genre_id).posts
      favorite = Post.where(id: (target_genre_post & favorite_post))
      @posts = Kaminari.paginate_array(favorite)
    else
      @posts = Genre.find(genre_id).posts.where("title LIKE ?","%#{keyword}%")
      @posts = Kaminari.paginate_array(@posts)
    end
  end
end
