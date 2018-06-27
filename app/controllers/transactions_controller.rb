class TransactionsController < ApplicationController

  def index
    @transactions_c = Transaction.where(account_id: current_user.account.id)
    @transactions_d = current_user.transactions

    @transactions = @transactions_c.or(@transactions_d).order("created_at")
    #@transactions = Transaction.where(account_id: account_id or user_id: current_user.id)
  end

  def new
    @transaction = Transaction.new
  end

  def create
    @account_no = params[:transaction].values[0]
    @amount = params[:transaction].values[1]
    @otp = params[:transaction].values[2]

    @account1 = current_user.account
    @account2 = Account.find_by_account_no(@account_no)
    
    if beneficiary_exist? && @account1.otp == @otp
      @account2.update_columns(balance: (@account2.balance.to_i + @amount.to_i))
      @account1.update_columns(balance: (@account1.balance.to_i - @amount.to_i), otp: nil)
      Transaction.create!(account_id: @account2.id, user_id: current_user.id, amount: @amount)
      
      TransactionMailer.amount_deducted(current_user, @amount).deliver
      TransactionMailer.amount_credited(@account2.user, @amount).deliver

      redirect_to transactions_path
    else
      flash[:notice] = "This account number does not exist in your beneficiary list or invalid otp"
      redirect_to new_transaction_path
    end
  end

  def generate_otp
    otp = SecureRandom.random_number(9e3).to_i
    @account = Account.find(params[:id])
    @account.update_columns(otp: otp)
    TransactionMailer.send_otp(current_user, otp).deliver

    respond_to do |format|
      format.js
    end
  end

  def beneficiary_exist?
    current_user.beneficiaries.where(account_no: @account_no).first
  end

end
