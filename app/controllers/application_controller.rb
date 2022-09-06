class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  # devise_controllerであれば呼び出しを行う
  before_action :configure_permitted_parameters, if: :devise_controller?
  protected

  def configure_permitted_parameters
    # (追加したいメソッドの種類, keys: [追加したいパラメーター名])
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name,:last_name])
  end
    # もしログインしているIDがゲストユーザーなら遷移させる
  def guest_check
    if current_menber == Menber.find(1)
      redirect_to root_path, notice: "こちらを利用するには会員登録が必要です。"
    end
  end
end