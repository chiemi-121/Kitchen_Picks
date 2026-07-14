class Admin::DashboardController < Admin::BaseController
  def show
    @users_count = User.count
    @posts_count = Post.count
    @comments_count = Comment.count
  end
end