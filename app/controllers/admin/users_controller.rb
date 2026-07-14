class Admin::UsersController < Admin::BaseController
  before_action :set_user, only: [:show, :deactivate, :activate]

  def index
    @users = User.includes(:posts, :comments).order(created_at: :desc)
  end

  def show
  end

  def deactivate
    @user.update!(is_active: false)
    reset_session if current_user == @user
    redirect_to admin_user_path(@user), notice: "ユーザーを利用停止にしました。"
  end

  def activate
    @user.update!(is_active: true)
    redirect_to admin_user_path(@user), notice: "ユーザーの利用停止を解除しました。"
  end

  private

  def set_user
    @user = User.find(params[:id])
  end
end