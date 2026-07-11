class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:email])
    logger.info("[auth][login] attempt email=#{params[:email].inspect} user_found=#{user.present?}")

    if user&.authenticate(params[:password])
      session[:user_id] = user.id
      logger.info("[auth][login] success user_id=#{user.id}")
      redirect_to mypage_path, notice: "ログインしました！"
    else
      logger.warn("[auth][login] failed email=#{params[:email].inspect}")
      flash.now[:alert] = "メールアドレスまたはパスワードが違います"
      render :new, status: :unprocessable_entity
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