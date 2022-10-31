class ApplicationController < ActionController::Base
  include Pagy::Backend
  before_action :authorized?
  helper_method :current_user, :logged_in?, :admin?, :can_edit, :member?, :login_attempts, :countdown

  def current_user
    @current_user ||= User.find_by(auth_token: cookies[:auth_token])
  end

  def login_attempts(params)
    params[:user][:failed_attempts] += 1
  end

  def logged_in?
    !!current_user
  end

  def authorized?
    redirect_to root_path unless logged_in?
  end

  def member?
    redirect_to posts_path if current_user && current_user.user_type == 'User'
  end

  def user_exist?
    redirect_to posts_path if current_user
  end

  def admin?
    redirect_to posts_path unless current_user.user_type == 'Admin'
  end

  def can_edit(post)
    post.user_id == current_user.id || current_user.user_type == 'Admin'
  end

  def countdown(time_sec)
    time_sec.downto(0) do |t|
      redirect_to root_path, notice: "%02d:%02d\r" % t.divmod(60)
      sleep 1
    end
  end
end
