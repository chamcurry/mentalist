class PostsController < ApplicationController
  # ゲストユーザーとしてログインした場合は閲覧を制限する
  before_action :guest_check,except: [:show]

  def index
    @posts= Post.search(params[:search])
    @genres=Genre.genre_search(params[:search])
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

  def destroy
  end

  private
  def post_params
    params.require(:post).permit(:menber_id, :title,:body,:star,:image,genre_ids: [])
  end
end