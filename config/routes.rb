Rails.application.routes.draw do
  namespace :admin do
    get "/login", to: "sessions#new"
    post "/login", to: "sessions#create"
    delete "/logout", to: "sessions#destroy"

    root to: "dashboard#show"
    get "/dashboard", to: "dashboard#show", as: :dashboard
    resources :posts, path: "reviews", only: [:index, :show, :destroy]
    resources :comments, only: [:destroy]
    resources :users, only: [:index, :show] do
      member do
        patch :deactivate
        patch :activate
      end
    end
  end

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

  # ゲストログイン
  post "/guest_login", to: "sessions#guest_login"

  # 投稿
  resources :posts, only: [:new, :create, :show, :index, :edit, :update, :destroy]

  # コメント
  resources :comments, only: [:create, :destroy]

  # カテゴリ（重複ルート削除済み）
  resources :categories, only: [:index, :show]

  # タグ
  resources :tags, only: [:index, :show]

  # ユーザー詳細・編集・退会
  resources :users, only: [:show, :edit, :update, :destroy]

  # ヘルスチェック
  get "up" => "rails/health#show", as: :rails_health_check
end