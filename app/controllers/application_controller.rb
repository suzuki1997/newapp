class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  #applicationコントローラーでSessionsヘルパーを読み込む事で、どこでもSessionsヘルパーを使えるようになる
  include SessionsHelper
  
  
  private
  
  #usersコントローラからapplicationコントローラにlogged_in_userメソッドを移す事で、postコントローラからでもlogged_in_userメソッドを使えるようにする
  def logged_in_user
    unless logged_in?
      store_location
      flash[:notice] = "ログインしてください"
      redirect_to login_url
    end
  end
  
 
end
