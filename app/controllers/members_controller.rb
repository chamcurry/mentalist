class MembersController < ApplicationController
  before_action :guest_check,except: [:privacy,:terms]

  def like_list
    favorite = Favorite.where(member_id: current_member.id).pluck(:post_id)
    favorite_post = Post.where(id: favorite).order("created_at desc")
    # favorite_post = Post.find(favorite)
    # favorite = Post.joins(:favorite).where("favorites.member_id = ?",current_member.id).order("favorites.created_at desc")
    @posts = Post.like_search(params, favorite, favorite_post)
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