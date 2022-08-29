class HomesController < ApplicationController
  before_action :authenticate_menber!,except: [:top]
  
  def top
    @posts = Post.all
    @menber = current_menber
  end
end