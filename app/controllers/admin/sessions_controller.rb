class Admin::SessionsController < ApplicationController
  layout "admin"
  before_action :redirect_if_admin_signed_in, only: [:new, :create]

  def new
  end

  def create
    admin = Admin.find_by(login_id: params[:login_id])

    if admin&.authenticate(params[:password])
      session[:admin_id] = admin.id
      redirect_to admin_root_path, notice: "管理者としてログインしました。"
    else
      flash.now[:alert] = "管理者IDまたはパスワードが違います。"
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    session.delete(:admin_id)
    redirect_to admin_login_path, notice: "管理者ログアウトしました。"
  end

  private

  def redirect_if_admin_signed_in
    return unless admin_signed_in?

    redirect_to admin_root_path, notice: "既に管理者ログインしています。"
  end
end