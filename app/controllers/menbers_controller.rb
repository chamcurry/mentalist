class MenbersController < ApplicationController
  before_action :guest_check

  def like_list
   @menber = current_menber
   favorite = Favorite.where(menber_id: current_menber.id).pluck(:post_id)
   @favorite = Post.where(id: favorite)
   # @posts = Kaminari.paginate_array(@posts).page(params[:page]).per(6)
   if params[:search].blank? && params[:genre_id].blank?
      @posts = Kaminari.paginate_array(@favorite).page(params[:page]).per(6)

   elsif params[:search].present? && params[:genre_id].blank?
      favorites = @favorite.where("title LIKE ?","%#{params[:search]}%")
      @posts = Kaminari.paginate_array(favorites).page(params[:page]).per(6)

   elsif params[:search].blank? && params[:genre_id].present?
      target_genre_post_ids = Genre.find(params[:genre_id]).posts.ids #[1,2,3]
      favorite_post_ids = @favorite.ids #[2,3,4]
      @favorite = Post.where(id: (target_genre_post_ids & favorite_post_ids))
      @posts = Kaminari.paginate_array(@favorite).page(params[:page]).per(6)

   else
      # search title
      favorites_ids = @favorite.where("title LIKE ?","%#{params[:search]}%").ids
      # search genre
      target_genre_post_ids = Genre.find(params[:genre_id]).posts.ids #[1,2,3]
      favorite_post_ids = @favorite.ids #[2,3,4]
      @favorite = Post.where(id: ((target_genre_post_ids & favorite_post_ids) + favorites_ids).uniq)
      @posts = Kaminari.paginate_array(@favorite).page(params[:page]).per(6)
   end
  end
  def my_page
   @menber = current_menber
   @posts = @menber.posts.all
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