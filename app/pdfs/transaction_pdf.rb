class TransactionPdf < Prawn::Document
  def initialize(transactions_details, user)
    super(top_margin: 20)
    @transactions = transactions_details
    @user = user
    # @account = user.account
    account
    transactions
    net_balance
  end

  def account
    text "Mini Statement for Account: #{@user.account.account_no}",size: 15, style: :italic
    text "Bank: #{ @user.bank.name }"
  end
  
  def transactions
    move_down(30)
    table transactions_rows do
      row(0).font_style = :bold
      columns(1..4).align = :center
      self.row_colors = ['DDDDDD', 'FFFFFF']
      self.header = true
    end
  end

  def transactions_rows
    [["Account_number", "Amount", "Time", "Transaction"]] +
    @transactions.order("created_at").map do |transaction|
      [
        account_no(transaction.account, transaction.user.account),
        transaction.amount,
        transaction.created_at.strftime("%d-%m-%Y --%H-%M-%S"),
        transaction_type(transaction.account, transaction.user.account)
      ]
    end
  end

  def account_no(to_account, from_account)
    if to_account.id  == @user.account.id
      from_account.account_no
    else
      to_account.account_no
    end
  end

  def transaction_type(from_account, to_account)
    if to_account.id == @user.account.id
      'DEBIT'
    else
      'CREDIT'
    end
  end

  def net_balance
    move_down(30)
    text  "BALANCE: #{ @user.account.balance.to_s } Rs.", style: :bold
  end
end
