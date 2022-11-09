module AuthHelper
  def current_user
    @current_user ||= User.where(email: "test@gmail.com").take
  end
end
