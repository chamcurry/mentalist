# frozen_string_literal: true

class Menber::SessionsController < Devise::SessionsController
  before_action :configure_sign_in_params, only: [:create]

  def guest_sign_in
    guest = Menber.guest_user
    sign_in guest   # ユーザーをログインさせる
    redirect_to root_path, notice: 'ゲストユーザーとしてログインしました。'
  end
  # GET /resource/sign_in
  # def new
  #   byebug
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

  protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
  # 退会しているか判断するためのメソッド
  def configure_sign_in_params
    # [処理内容１]入力されたemailからアカウントを1件取得
    @menber = Menber.find_by(email: params[:menber][:email])
    # アカウントが取得できない場合、このメソッドを終了する
    return if !@menber # [処理内容２]取得したアカウントのパスワードと入力されたパスワードが一致しているか判別
      # [処理内容３]is_activeの値がtrueだった場合、サインアップ画面に遷移させる
    if @menber.valid_password?(params[:menber][:password]) && @menber.is_active == true
       redirect_to new_menber_registration_path,notice: 'このアカウントは既に退会されています。'
    end
  end
end
