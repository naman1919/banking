class BeneficiariesController < ApplicationController
  def index
    @beneficiaries = current_user.beneficiaries
  end

  def new
    @beneficiary = Beneficiary.new
  end

  def create
    # byebug
    account_no = params[:beneficiary].values[0]
    account = Account.find_by_account_no(account_no)
    
    if account
      if account.user.verify
        Beneficiary.create(beneficiary_params)
        current_user.beneficiaries << Beneficiary.last
        UserMailer.beneficiary_added(current_user).deliver
        redirect_to  beneficiaries_path
      end
    else
      redirect_to new_beneficiary_path
      flash[:notice] = "Please provide valid account number"
    end
  end

  private

  def beneficiary_params
    params.require(:beneficiary).permit(:name, :account_no)
  end
end
