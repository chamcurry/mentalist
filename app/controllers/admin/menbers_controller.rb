class Admin::MenbersController < ApplicationController
  before_action :authenticate_admin!
  def index
    @kaminari = Menber.all.page(params[:page]).per(5)
  end

  def update
    @menber = Menber.find(params[:id])
    @menber.update(is_active: true)
    redirect_to admin_menbers_path
  end

  def withdraw
    @menber = Menber.find(params[:id])
    @menber.update(is_active: false)
    redirect_to admin_menbers_path
  end
end
