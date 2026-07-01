class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:email])

    if user && user.encrypted_password == Digest::SHA256.hexdigest(params[:password])
      session[:user_id] = user.id
      redirect_to mypage_path, notice: "ログインしました！"
    else
      flash.now[:alert] = "メールアドレスまたはパスワードが違います"
      render :new
    end
  end

  def destroy
    reset_session
    redirect_to root_path, notice: "ログアウトしました"
  end
end