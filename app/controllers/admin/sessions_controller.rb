# frozen_string_literal: true

class Admin::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]
  def new_guest
    guest = Menber.guest
    sign_in guest   # ユーザーをログインさせる
    redirect_to posts_path, notice: 'ゲストユーザーとしてログインしました。'
  end
  # def new_guest
  #   guest = Menber.find_by(email: 'guest_user@example.com')
  #   guest.encrypted_password = guestpassword
  #   sign_in guest
  #   redirect_to root_path,notice: 'ゲストユーザーとしてログインしました！'
  # end
  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
