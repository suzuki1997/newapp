module SessionsHelper
  
  def log_in(user)
    session[:user_id] = user.id
  end
  
  def current_user
    #session[:user_id]をuser_idに代入した結果user_idが存在すれば下記の処理を実行
    if (user_id = session[:user_id])
      @current_user ||= User.find_by(id: user_id)
    #cookiesに保存されているuser_idがある場合は以下の処理を実行
    elsif (user_id = cookies.signed[:user_id])
      user = User.find_by(id: user_id)
      #user.rb内のauthenticated?メソッドを実行し、cookiesのrememberトークンがrememberダイジェストと一致するか確認
      if user && user.authenticated?(cookies[:remember_token])
        log_in user
        @current_user = user
      end
    end
  end
  
  
  def logged_in?
    !current_user.nil?
  end
  
  #永続的なセッションを消去する
  def forget(user)
    #user.rb内のforgetメソッドを実行し、userのremember_digestをnilにする
    user.forget
    cookies.delete(:user_id)
    cookies.delete(:remember_token)
  end
  

  
  def log_out
    #現在のユーザーの永続セッションを消去する(ログアウトすると永続セッションが自動的に解除される)
    forget(current_user)
    session.delete(:user_id)
    @current_user = nil
  end
  
  def remember(user)
    #引数を用いてuser.rb内のrememberメソッドを呼び出す
    user.remember
    #ユーザーidとrememberトークンを永続セッションにする
    cookies.permanent.signed[:user_id] = user.id
    cookies.permanent[:remember_token] = user.remember_token
  end
  
end
