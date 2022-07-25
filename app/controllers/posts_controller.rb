class PostsController < ApplicationController
  def index
  end

  def new
  end

  def create
  end

  def show
  end

  def search
    @posts = Post.search(params:[:keyword])
    @keyword = params[:keyword]
  end
  def destroy
  end
end
