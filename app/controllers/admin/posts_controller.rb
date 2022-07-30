class Admin::PostsController < ApplicationController
  def index
    @kaminari = Post.all.page(params[:page]).per(5)
  end

  def show
  end

  def destroy
  end
end
