class FavoritesController < ApplicationController
  def create
    post = Post.find(params[:post_id])
    favorite = current_menber.favorites.new(post_id: post.id)
    fav = favorite.reorder('favorites.created_at DESC')
    fav.save
    redirect_back fallback_location: {action: "create"}
  end

  def destroy
    post = Post.find(params[:post_id])
    favorite = current_menber.favorites.find_by(post_id: post.id)
    fav = favorite.reorder('favorites.created_at DESC')
    fav.destroy
    redirect_back fallback_location: {action: "destroy"}
  end
end
