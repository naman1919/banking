class TransactionsController < ApplicationController

  def index
    @transactions = Transaction.all
  end

  def new
    @transaction = Transaction.new
  end

  def create

    account_no = params[:transaction].values[0]
    amount = params[:transaction].values[1]
    
    account1 = current_user.account
    account2 = Account.find_by_account_no(account_no)
    
    beneficiary_exist = current_user.beneficiaries.where(account_no: account_no).first

    if beneficiary_exist
      account2.update_columns(balance: (account2.balance + amount.to_i))
      account1.update_columns(balance: (account1.balance - amount.to_i))
      Transaction.create(from_account_no: current_user.account.account_no, credit: true, to_account_no: account_no)
    end
  end

end
