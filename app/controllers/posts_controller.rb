class PostsController < ApplicationController
  # ゲストユーザーとしてログインした場合は閲覧を制限する
  before_action :guest_check,except: [:index,:show]
  before_action :authenticate_menber!
  def index
    # @posts = Post.search(params[:search])
    if params[:search].blank? && params[:genre_id].blank?
      @posts = Post.all
    elsif params[:search].present? && params[:genre_id].blank?
      @posts = Post.where("title LIKE ?","%#{params[:search]}%")
    elsif params[:search].blank? && params[:genre_id].present?
      @posts = Genre.find(params[:genre_id]).posts
    else
      @posts = Genre.find(params[:genre_id]).posts.where("title LIKE ?","%#{params[:search]}%")
    end
    @menber = current_menber
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
    @menber = current_menber
  end

  def destroy
  end

  private
  def post_params
    params.require(:post).permit(:menber_id, :title,:body,:star,:image,genre_ids:[])
  end
end