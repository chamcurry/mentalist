class MenbersController < ApplicationController
  before_action :guest_check

  def like_list
   favorites = Favorite.where(menber_id: current_menber.id).pluck(:post_id)
   @favorite_posts = Post.find(favorites)
   @favorite_posts = Kaminari.paginate_array(@favorite_posts).page(params[:page])
   @menber = current_menber
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