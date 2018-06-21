class UserMailer < ApplicationMailer
  default from: 'naman.dengre@gmail.com'

  def welcome_email
    @user = User.find(params[:id])
    mail(to: @user.email, subject: 'Welcome to Bank Management System')
  end
end
