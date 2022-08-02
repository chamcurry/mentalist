class Admin::PostsController < ApplicationController
  def index
    @kaminari = Post.all.page(params[:page]).per(5)
  end

  def show
    @post = Post.find(params[:id])
  end

  def destroy
  end
end
