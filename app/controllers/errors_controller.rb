class ErrorsController < ApplicationController
  def not_found
    render file: "#{Rails.root}/public/404.html"
  end
  def internal_server_error
    render file: "#{Rails.root}/public/500.html"
  end
end
