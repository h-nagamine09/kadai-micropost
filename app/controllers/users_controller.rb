class UsersController < ApplicationController
  # 事前に実行される処理
 before_action :require_user_logged_in,only: [:index, :show, :followings, :followers]
 
  def index
    #.allでDB一覧を取得　全ユーザー一覧　ページネーションを適用させるために.page(params[:page])をつけてる
    @users = User.all.page(params[:page])
  end

  def show
    # .findでidを取得
    @user = User.find(params[:id])
    @microposts = @user.microposts.order('created_at DESC').page(params[:page])
    counts(@user)
  end

  def new
    # .newで新規データ取得
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    #ユーザーの登録に成功すると'ユーザを登録しました'の表示
    if @user.save
      flash[:success] = 'ユーザを登録しました'
      #処理を users#showに強制的に移動させるもの。createアクションを実行後さらにshowアクションが実行され、show.html.erbが呼ばれる
      redirect_to @user
    else
      #登録できなかった場合'ユーザの登録に失敗しました'の表示とnew.htmlに飛ぶ
      flash.now[:danger] = 'ユーザの登録に失敗しました'
    　render :new
      ()
    end
  end
  
  def followings
    @user - User.find(params[:id])
    @followings = @user.followings.page(params[:page])
    counts(user)
  end 
  
  def followers
    @user = User.find(params[:id])
    @followers = @user.followers.page(params[:page])
    counts(user)
  end
　#Strong Paramter セキュリティのため
　#name,email,password,password_confirmationを許可。
  private
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end 
end 