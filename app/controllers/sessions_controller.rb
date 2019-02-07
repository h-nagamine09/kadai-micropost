class SessionsController < ApplicationController
  def new
    #対応するモデルがないのでコードの追加なし
    #新規に投稿する項目がないため
  end
  
    #sessions#createが実質的にログイン処理を担当するアクションになる
  def create
    email = params[:session][:email].downcase #downcaseで大文字を小文字に自動変換
    password = params[:session][:password]
    if login(email,password)
      flash[:success] = 'ログインに成功しました'
      redirect_to @user #ログイン成功後ユーザーページ(users#show)を表示
    else
      flash.now[:danger] = 'ログインに失敗しました'
      render 'new' #入力画面がrenderで呼び出される(sessions/new.html.erbを再表示)
    end 
  end

  def destroy
    #session[:user_id] = nilで:user_idを削除することでログアウト
    session[:user_id] = nil
    flash[:success] = 'ログアウトしました'
    # ログアウト後はredirect_to root_urlによってトップページへリダイレクトされる
    redirect_to root_url
  end
  
  private
  
    def login(email,password)
      #入力フォームのEmailアドレスから同じemailアドレスを検索し@userに代入
      @user = User.find_by(email: email)
      #if @user~によって同じユーザーがいるか確認
      if @user && @user.authenticate(password)
        #email,passwordが一致する場合、ログイン成功(true)
        session[:user_id] = @user.id 
        #ブラウザにはcookieとして、サーバーにはsessionとしてログイン状態が維持される
        return true
      else
        #一致するユーザーが見つからなかった場合(else)、ログイン失敗(false)
        return false
      end 
    end
end


 
 
