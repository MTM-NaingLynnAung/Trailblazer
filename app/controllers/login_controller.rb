class LoginController < ApplicationController
  skip_before_action :authorized?
  def login
    run User::Operation::Login::Present
  end

  def action_login
    run User::Operation::Login do |result|
      session[:user_id] = result[:user][:id]
      redirect_to posts_path, notice: 'Login Successfully'
      return
    end
    if result.failure? && result[:email_pwd_fail]
      redirect_to root_path, alert: 'Email or Password invalid'
    end
  end

  def logout
    session[:user_id] = nil
    redirect_to root_path, notice: 'Logout Successfully'
  end
end
