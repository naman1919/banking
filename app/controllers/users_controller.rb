class UsersController < ApplicationController
  def verify
    @user = User.find(params[:id])
    @user.update_columns(verify: true)
    
    UserMailer.verify_user(@user).deliver

    redirect_to welcome_index_path
  end 
end
