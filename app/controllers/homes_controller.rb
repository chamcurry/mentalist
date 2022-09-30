class HomesController < ApplicationController
  before_action :authenticate_member!,except: [:top]

  def top
    @posts = Post.all.order(id: "DESC").page(params[:page]).per(6)
  end
end
