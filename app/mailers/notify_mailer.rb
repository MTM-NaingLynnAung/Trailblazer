class NotifyMailer < ApplicationMailer
  def notify
    mail to: params[:email]
    post = params[:post]
  end
end
