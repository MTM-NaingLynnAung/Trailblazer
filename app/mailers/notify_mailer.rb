class NotifyMailer < ApplicationMailer
  def notify
    mail to: params[:email]
  end
end
