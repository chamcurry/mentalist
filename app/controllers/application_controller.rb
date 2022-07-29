class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_sign_in_params, only: [:create]
  protected
  # 退会しているか判断するためのメソッド
  def configure_sign_in_params
    # [処理内容１]入力されたemailからアカウントを1件取得
    @menber = Menber.find_by(email: params[:menber][:email])
    # アカウントが取得できない場合、このメソッドを終了する
    return if !@menber
    # [処理内容２]取得したアカウントのパスワードと入力されたパスワードが一致しているか判別
    if @menber.valid_password?(params[:menber][:password]) && @menber.is_active == true
      # [処理内容３]is_activeの値がtrueだった場合、サインアップ画面に遷移させる
       redirect_to new_menber_registration_path
    end
  end
end