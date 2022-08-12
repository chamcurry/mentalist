class MenbersController < ApplicationController
  before_action :guest_check
  def show
   @menber = current_menber
   @posts = @menber.posts.all
  end
  def edit
   @menber = current_menber
  end
  def update
  end
  def withdraw
  end

  private
  def menber_params
   params.require(:menber).permit(:last_name,:first_name,:is_active,:profile_image)
  end
end