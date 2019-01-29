class UsersController < ApplicationController
 before_action :require_user_logged_in,only: [:index, :show]
 
  def index
    #.allでDB一覧を取得
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
    #ユーザーの登録
    if @user.save!
      flash[:success] = 'ユーザを登録しました'
      redirect_to @user
    else
      flash.now[:danger] = 'ユーザの登録に失敗しました'
      render :new
  end
end
     private

   def user_params
     params.require(:user).permit(:name, :email, :password, :password_confirmation)
   end 
 end 