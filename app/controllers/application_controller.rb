class ApplicationController < ActionController::Base
  before_action :current_user, :authorized?
  helper_method :current_user, :logged_in?, :admin?, :can_edit

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def logged_in?
    !!current_user
  end

  def authorized?
    redirect_to root_path unless logged_in?
  end

  def admin?
    redirect_to posts_path unless current_user.user_type == 'Admin'
  end

  def can_edit(post)
    post.user_id == current_user.id || current_user.user_type == 'Admin'
  end
end
