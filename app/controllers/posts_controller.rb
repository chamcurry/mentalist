class PostsController < ApplicationController
  # ゲストユーザーとしてログインした場合は閲覧を制限
  before_action :guest_check,except: [:index,:show]
  before_action :authenticate_menber!
  def index
    if params[:search].blank? && params[:genre_id].blank?
      @posts = Post.all.order(id: "DESC").page(params[:page]).per(6)
    elsif params[:search].present? && params[:genre_id].blank?
      @posts = Post.where("title LIKE ?","%#{params[:search]}%")
      @posts = Kaminari.paginate_array(@posts).page(params[:page]).per(6)
    elsif params[:search].blank? && params[:genre_id].present?
      @posts = Genre.find(params[:genre_id]).posts
      @posts = Kaminari.paginate_array(@posts).page(params[:page]).per(6)
    else
      @posts = Genre.find(params[:genre_id]).posts.where("title LIKE ?","%#{params[:search]}%")
      @posts = Kaminari.paginate_array(@posts).page(params[:page]).per(6)
    end
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_menber.posts.new(post_params)
    if @post.save
     redirect_to my_page_menbers_path
    else
     render :new
    end
  end

  def show
    @post = Post.find(params[:id])
    @post_comment = Comment.new
  end

  def destroy
    @post = Post.find(params[:id]).destroy
    redirect_to root_path
  end

  private
  def post_params
    params.require(:post).permit(:menber_id, :title,:body,:star,:image,genre_ids:[])
  end
end
