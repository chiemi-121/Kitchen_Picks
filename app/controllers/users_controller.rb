class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :require_login, only: [:mypage, :edit, :update, :destroy]

  # 新規登録
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      session[:user_id] = @user.id
      redirect_to mypage_path, notice: "登録が完了しました！"
    else
      render :new, status: :unprocessable_entity
    end
  end

  # マイページ
  def mypage
    @user = current_user
    @posts = @user.posts.order(created_at: :desc)
  end

  # ユーザー詳細
  def show
  end

  # 編集
  def edit
  end

  def update
    # パスワード変更がある場合のみ暗号化して保存
    if params[:user][:password].present?
      @user.encrypted_password = Digest::SHA256.hexdigest(params[:user][:password])
    end

    # user_params は name と email のみ
    if @user.update(user_params)
      redirect_to @user, notice: "プロフィールを更新しました！"
    else
      render :edit
    end
  end

  # 退会
  def destroy
    @user.destroy
    reset_session
    redirect_to root_path, notice: "退会しました。ご利用ありがとうございました！"
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def require_login
    redirect_to login_path, alert: "ログインしてください" unless current_user
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end