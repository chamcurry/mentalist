class MembersController < ApplicationController
  before_action :guest_check,except: [:privacy,:terms]

  def like_list
    # @posts = Post.like_search(params[:keyword],params[:genre_id]).page(params[:page]).per(6)
    favorite = Favorite.where(member_id: current_member.id).order("created_at desc").pluck(:post_id)
    favorite_post = Post.find(favorite)
    #Post.joins(:favorite).where("favorites.member_id = ?",current_member.id).order("favorites.created_at desc")
    if keyword.blank? && genre_id.blank?
      @posts = Kaminari.paginate_array(favorite_post)
    elsif keyword.present? && genre_id.blank?
      favorite = favorite_post.where("title LIKE ?","%#{keyword}%")
      @posts = Kaminari.paginate_array(favorite)
    elsif keyword.blank? && genre_id.present?
      target_genre_post = Genre.find(genre_id).posts
      favorite = Post.where(id: (target_genre_post & favorite_post))
      @posts = Kaminari.paginate_array(favorite)
    else
      @posts = Genre.find(genre_id).posts.where("title LIKE ?","%#{keyword}%")
      @posts = Kaminari.paginate_array(@posts)
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