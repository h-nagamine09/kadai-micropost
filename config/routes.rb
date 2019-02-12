Rails.application.routes.draw do
    root to: 'toppages#index'
  # resource :sessions, only: [:new,:create,:destroy]としても良いけどURLの見栄えを考慮して
  get 'login', to:'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to:'sessions#destroy'
  
  get 'signup', to: 'users#new'
  #ユーザーの新規URLを/signupにする users/newだとカッコ悪いから get 'signup'と個別に指定することで解決
  resources :users, only: [:index , :show , :new , :create] do
    member do 
      get :followings
      get :followers
      get :likes
    end
  end
    
  #必要なアクションだけ only:...として指定
  resources :microposts, only: [:create, :destroy]
  #必要なアクションのみ指定。createで投稿、destroyで投稿を削除
  
  # ログインユーザーがフォロー、アンフォローできるようにするルーティング
  resources :relationships, only: [:create , :destroy]
  # ログインユーザがお気に入りを登録できる
  resources :favorites, only: [:create, :destroy]
end
