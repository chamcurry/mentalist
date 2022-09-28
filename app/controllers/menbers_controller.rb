class MenbersController < ApplicationController
  before_action :guest_check

  def like_list
    favorite = Favorite.where(menber_id: current_menber.id).pluck(:post_id)
    favorite_post = Post.where(id: favorite)
    if params[:search].blank? && params[:genre_id].blank?
      @posts = Kaminari.paginate_array(favorite_post).page(params[:page]).per(6)
    elsif params[:search].present? && params[:genre_id].blank?
      favorite = favorite_post.where("title LIKE ?","%#{params[:search]}%")
      @posts = Kaminari.paginate_array(favorite).page(params[:page]).per(6)
    elsif params[:search].blank? && params[:genre_id].present?
      target_genre_post_ids = Genre.find(params[:genre_id]).posts.ids
      favorite_post_ids = favorite_post.ids
      favorite = Post.where(id: (target_genre_post_ids & favorite_post_ids))
      @posts = Kaminari.paginate_array(favorite).page(params[:page]).per(6)
    else
      @posts = Genre.find(params[:genre_id]).posts.where("title LIKE ?","%#{params[:search]}%")
      @posts = Kaminari.paginate_array(@posts).page(params[:page]).per(6)
    end
  end
  def my_page
    @posts = current_menber.posts.all
  end
  def edit
    @menber = current_menber
    if @menber == current_menber
      render :edit
    else
      redirect_to root_path
    end
  end
  def update
    @menber = current_menber
    if @menber == current_menber
      @menber.update(menber_params)
      redirect_to my_page_menbers_path
    else
      render :edit
    end
  end
  def withdraw
    @menber = current_menber
    @menber.update(is_active: true)
    reset_session
    redirect_to root_path
  end
  private
  def menber_params
    params.require(:menber).permit(:last_name,:first_name,:is_active,:email,:profile_image)
  end
end