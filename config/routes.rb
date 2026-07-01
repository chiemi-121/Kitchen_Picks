Rails.application.routes.draw do
  root to: "homes#top"
  get "/about", to: "homes#about"

  # マイページ
  get "/mypage", to: "users#mypage"

  # サインアップ（ユーザー登録）
  get  "/signup", to: "users#new"
  post "/signup", to: "users#create"

  # ログイン
  get    "/login",  to: "sessions#new"
  post   "/login",  to: "sessions#create"
  delete "/logout", to: "sessions#destroy"

  # 投稿
  resources :posts, only: [:new, :create, :show, :index, :edit, :update, :destroy]

  # コメント
  resources :comments, only: [:create]

  # ユーザー詳細・編集・退会
  resources :users, only: [:show, :edit, :update, :destroy]

  # ヘルスチェック
  get "up" => "rails/health#show", as: :rails_health_check
end