class Admin::MembersController < ApplicationController
  before_action :authenticate_admin!
  def index
    @kaminari = Member.all.page(params[:page]).per(5)
  end

  def update
    @member = Member.find(params[:id])
    @member.update(is_active: true)
    redirect_to admin_members_path
  end

  def withdraw
    @member = Member.find(params[:id])
    @member.update(is_active: false)
    redirect_to admin_members_path
  end
end
