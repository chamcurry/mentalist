class PostsController < ApplicationController
  def index
    # @posts = Post.all
     @posts = params[:genre_id].present? ? Genre.find(params[:genre_id]).posts: Post.all
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