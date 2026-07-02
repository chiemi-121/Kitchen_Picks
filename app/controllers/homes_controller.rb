class HomesController < ApplicationController
  layout :choose_layout

  def top
  end

  private

  def choose_layout
    if user_signed_in?
      "application"   # ログイン後 → 共通ヘッダー（投稿一覧・新規投稿・マイページ・ログアウト）
    else
      "top"           # 未ログイン → Sign up / Log in の専用ヘッダー
    end
  end
end