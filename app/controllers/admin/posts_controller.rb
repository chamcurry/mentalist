class Admin::PostsController < ApplicationController
   before_action :authenticate_admin!
  def index
    @posts = Post.all.page(params[:page]).per(5)
  end

  def show
    @post = Post.find(params[:id])
  end

  def destroy
    Post.find(params[:id]).destroy
    redirect_to admin_posts_path
  end
end
