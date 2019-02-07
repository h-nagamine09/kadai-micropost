class ToppagesController < ApplicationController
  # Toppages/index.html.erbにMicropostを投稿するフォームを設置
  def index
    if logged_in?
      #form_for用 @micropostにカラのインスタンスを代入
      @micropost = current_user.microposts.build
      # 一覧用
      @microposts = current_user.microposts.order('created_at DESC').page(params[:page])
    end
  end
end
