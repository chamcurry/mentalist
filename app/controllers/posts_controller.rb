class PostsController < ApplicationController
  # ゲストユーザーとしてログインした場合は閲覧を制限
  before_action :guest_check,except: [:index,:show]
  before_action :authenticate_member!
  def index
    @posts = Post.search(params[:keyword],params[:genre_id]).page(params[:page]).per(6)
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_member.posts.new(post_params)
    if @post.save
     redirect_to my_page_members_path
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
    params.require(:post).permit(:member_id, :title,:body,:star,:image,genre_ids:[])
  end
end
