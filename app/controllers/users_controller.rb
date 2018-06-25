class UsersController < ApplicationController
  def verify
    @user = User.find(params[:id])
    @user.update_columns(verify: true)

    @account = Account.new(account_no: (SecureRandom.random_number(9e11) + 1e11).to_i, user_id: @user.id)
    @account.save!
    
    UserMailer.verify_user(@user).deliver

    redirect_to welcome_index_path
  end 
end
