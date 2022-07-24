class HomesController < ApplicationController
  def top
  end
  def new_guest
   guest = Menber.find_by(email: 'guest_user@example.com')
   sign_in guest
   redirect_to admin_posts_path,notice: 'ゲストユーザーとしてログインしました！'
  end
end