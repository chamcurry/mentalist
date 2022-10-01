class MembersController < ApplicationController
  before_action :guest_check

  def like_list 
    favorite = Favorite.where(member_id: current_member.id).order("created_at desc").pluck(:post_id)
    favorite_post = Post.find(favorite)
    #Post.joins(:favorite).where("favorites.member_id = ?",current_member.id).order("favorites.created_at desc")
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
    @posts = current_member.posts.all
  end
  def edit
    @member = current_member
    if @member == current_member
      render :edit
    else
      redirect_to root_path
    end
  end
  def update
    @member = current_member
    if @member == current_member
      @member.update(member_params)
      redirect_to my_page_members_path
    else
      render :edit
    end
  end
  def withdraw
    @member = current_member
    @member.update(is_active: true)
    reset_session
    redirect_to root_path
  end
  private
  def member_params
    params.require(:member).permit(:last_name,:first_name,:is_active,:email,:profile_image)
  end
end