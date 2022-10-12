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
  # 投稿一覧
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
  # お気に入り一覧
  def self.like_search(params, favorite, favorite_post)

    if params[:search].blank? && params[:genre_id].blank?
      posts = Kaminari.paginate_array(favorite_post).page(params[:page]).per(6)
    elsif params[:search].present? && params[:genre_id].blank?
      favorite = favorite_post.where("title LIKE ?","%#{params[:search]}%")
      posts = Kaminari.paginate_array(favorite).page(params[:page]).per(6)
    elsif params[:search].blank? && params[:genre_id].present?
      target_genre_post_ids = Genre.find(params[:genre_id]).posts
      favorite_post_ids = favorite_post
      favorite = Post.where(id: (target_genre_post_ids & favorite_post_ids))
      posts = Kaminari.paginate_array(favorite).page(params[:page]).per(6)
    else
      posts = Genre.find(params[:genre_id]).posts.where("title LIKE ?","%#{params[:search]}%")
      posts = Kaminari.paginate_array(posts).page(params[:page]).per(6)
    end
    return posts
  end
end
