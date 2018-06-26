class UserMailer < ApplicationMailer
  default from: "bankingsystem@example.com"
  
  def verify_user(user)
    @user = user
    @url = "http://localhost:3000/welcome/index"
    
    mail(to: @user.email, subject: "Welcome to Banking System")
  end

  def beneficiary_added(user)
    @user = user

    mail(to: @user.email, subject: "Beneficiary Added Successfully")
  end
end
