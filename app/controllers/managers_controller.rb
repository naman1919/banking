class ManagersController < ApplicationController
  def index
    @banks = Bank.all
  end

  def new
  end

  def create
    account = Account.find_by_account_no(params[:account_number])
    if account
      user = account.user
      bank = user.bank
      user.add_role :manager
    
      bank.update_columns(manager_name: user.first_name + " " + user.last_name)
      redirect_to managers_path
    else
      flash[:alert] = "Please Provide account number"
      redirect_to new_manager_path
    end
  end
end

