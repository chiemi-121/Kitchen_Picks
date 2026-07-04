class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:email])

    if user&.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to mypage_path, notice: "ログインしました！"
    else
      flash.now[:alert] = "メールアドレスまたはパスワードが違います"
      render :new
    end
  end

  def guest_login
    user = User.find_by(email: "guest@example.com")
    reset_session  # ← これ重要！
    session[:user_id] = user.id
    redirect_to posts_path, notice: "ゲストとしてログインしました"
  end

  def destroy
    session.delete(:user_id)
    redirect_to root_path, notice: "ログアウトしました"
  end
end