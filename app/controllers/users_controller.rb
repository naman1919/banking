class UsersController < ApplicationController
  def index
    if current_user.has_role? :admin
      @users = User.all
    elsif current_user.has_role? :manager
      @users = current_user.bank.users
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def verify
    @user = User.find(params[:id])
    @user.update_columns(verify: true)
    @user.update_columns(verified_by: current_user.roles.last.name)
    
    UserMailer.verify_user(@user).deliver

    redirect_to welcome_index_path
  end 
end
