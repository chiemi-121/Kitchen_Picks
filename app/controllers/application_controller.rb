class ApplicationController < ActionController::Base
  helper_method :current_user, :user_signed_in?

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def user_signed_in?
    current_user.present?
  end


  def require_login
    unless current_user
      redirect_to login_path, alert: "ログインしてください"
    end
  end
end