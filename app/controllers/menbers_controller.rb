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
end