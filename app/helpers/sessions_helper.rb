module SessionsHelper
  def current_user
    # @current_userに現在のログインユーザーが代入されていたらなにもしない
    # 代入されていなかったらUser.find...からログインユーザを取得し@current_userに代入する処理
    @current_user ||= User.find_by(id: session[:user_id])
  end
  
  # @current_user ||= User.find_by(id: session[:user_id])は以下のコードと同じ

# if @current_user
#   return @current_user
# else
#   @current_user = User.find_by(id: session[:user_id])
#   return @current_user
# end

  def logged_in?
    !!current_user
  end
end 
# ログインしていればtureを返し、ログインしていればfalseを返す処理
# 下記のコードも同じ意味
# if current_user
#   return true
# else
#   return false
# end