class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  
  include SessionsHelper
  
  #users#index,users#showのアクションには必ず事前にログイン認証を確認する処理
  private
  
   def require_user_logged_in
     #unlessはifの反対。falseの時に処理を実行
     unless logged_in?
      redirect_to login_url
     end
   end 
end

#ApplicationControllerにメソッドを定義すると全てのControllerで定義したメソッドが使用できる