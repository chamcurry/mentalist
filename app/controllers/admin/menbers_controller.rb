class Admin::MenbersController < ApplicationController
  def index
    @kaminari = Menber.all.page(params[:page]).per(5)
  end

  def show
    @menber = Menbrer.find(params[:id])
  end

  def update
    @menber = Menber.find(params[:id])
    @menber.update(is_active: true)
    reset_session
    redirect_to admin_menbers_path
  end
end
