class PostsController < ApplicationController
  # ゲストユーザーとしてログインした場合は閲覧を制限する
  before_action :guest_check,except: [:show]
  
  def index
    # 該当するジャンルを検索。なければ全てを表示する
    @genres = params[:genre_id].present? ? Genre.find(params[:genre_id]).posts: Post.all
    @posts=  Post.all.page(params[:page]).per(5).search(params[:search])

    # genre_search = Genre.where("soup = ?",params[:soup]).pluck(:id)
    # key_search = Post.where("title LIKE (?)","#{params[:title]}").pluck(:id)
    # @submit_searh = Post.where("genre_id IN (?) or title IN (?)",key_search,genre_search)
    # @posts = Post.all

  end
  def new
    @post = Post.new
  end

  def create
    @post = current_menber.posts.new(post_params)
   if @post.save
      redirect_to root_path
   else
      render :new
   end
  end

  def show
  end

  def search
    @posts = Post.search(params:[:keyword])
    @keyword = params[:keyword]
  end
  def destroy
  end

  private
  def post_params
    params.require(:post).permit(:menber_id, :title,:body,:star,:image,genre_ids: [])
  end
end