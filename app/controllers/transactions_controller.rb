class TransactionsController < ApplicationController

  def index
    @transactions_c = Transaction.where(account_id: current_user.account.id)
    @transactions_d = current_user.transactions

    @transactions = @transactions_c.or(@transactions_d).order("created_at")
  end

  def new
    @transaction = Transaction.new
  end

  def create
    @account_no = params[:transaction].values[0]
    amount = params[:transaction].values[1]
    otp = params[:transaction].values[2]

    from_account = current_user.account
    to_account = Account.find_by_account_no(@account_no)
    
    if from_account.otp == otp && amount.to_i < from_account.balance.to_i
      to_account.update_columns(balance: (to_account.balance.to_i + amount.to_i))
      from_account.update_columns(balance: (from_account.balance.to_i - amount.to_i), otp: nil)
      Transaction.create!(account_id: to_account.id, user_id: current_user.id, amount: amount)
      
      TransactionMailer.amount_deducted(current_user, amount).deliver
      TransactionMailer.amount_credited(to_account.user, amount).deliver

      redirect_to transactions_path
    else
      flash[:alert] = "Invalid otp or You have not sufficient balance in your account"
      redirect_to new_transaction_path
    end
  end
  
  def download_mini_statement
    index
    respond_to do |format|
      format.html
      format.pdf do
        pdf = TransactionPdf.new(@transactions, current_user)

        send_data pdf.render,
                  filename: "Ministatement_#{ current_user.first_name }.pdf",
                  type: 'application/pdf',
                  disposition: 'inline'
      end
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
end
