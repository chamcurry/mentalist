class HomesController < ApplicationController
  before_action :authenticate_menber!,except: [:top]

  def top
    @posts = Post.all.order(id: "DESC").page(params[:page]).per(6)
    @menber = current_menber
  end
end