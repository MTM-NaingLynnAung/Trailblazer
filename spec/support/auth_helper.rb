module AuthHelper
  def current_user
    @current_user ||= User.where(email: "admin@gmail.com").take
  end
end
