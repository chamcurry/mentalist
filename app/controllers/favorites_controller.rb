class FavoritesController < ApplicationController
  def create
    post = Post.find(params[:post_id])
    favorite = current_menber.favorites.new(post_id: post.id)
    favorite.save
    redirect_to menbers_my_page_path
  end

  def destroy
    post = Post.find(params[:post_id])
    favorite = current_menber.favorites.find_by(post_id: post.id)
    favorite.destroy
    redirect_to menbers_my_page_path
  end
end
