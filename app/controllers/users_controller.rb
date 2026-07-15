class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :require_login, only: [:mypage, :edit, :update, :destroy]
  before_action :ensure_current_user, only: [:edit, :update, :destroy]

  # 新規登録
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    logger.info("[auth][signup] attempt email=#{@user.email.inspect} name_present=#{@user.name.present?}")

    if @user.save
      session[:user_id] = @user.id
      logger.info("[auth][signup] success user_id=#{@user.id}")
      redirect_to mypage_path, notice: "登録が完了しました！"
    else
      logger.warn("[auth][signup] failed errors=#{@user.errors.full_messages.join(' | ')}")
      flash.now[:alert] = "登録に失敗しました。入力内容を確認してください。"
      render :new, status: :unprocessable_entity
    end
  end

  # マイページ
  def mypage
    @user = current_user
    @posts = @user.posts.order(created_at: :desc)
    @favorite_posts = @user.favorite_posts.includes(:user, :category).order("favorites.created_at DESC")
  end

  # ユーザー詳細
  def show
  end

  # 編集
  def edit
  end

  def update
    attributes = user_params.dup
    if attributes[:password].blank? && attributes[:password_confirmation].blank?
      attributes = attributes.except(:password, :password_confirmation)
    end

    if @user.update(attributes)
      redirect_to @user, notice: "プロフィールを更新しました！"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # 退会
  def destroy
    @user = User.find(params[:id])
    @user.update(is_active: false)   # 退会フラグ（必要なら）
    reset_session                    # ログアウト
    redirect_to signup_path, notice: "退会が完了しました。新規登録できます。"
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

  def ensure_current_user
    return if @user.id == current_user.id

    redirect_to mypage_path, alert: "他ユーザーの編集はできません"
  end
end