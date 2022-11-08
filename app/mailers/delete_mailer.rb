class DeleteMailer < ApplicationMailer
  def delete
    mail to: params[:email]
  end
end
