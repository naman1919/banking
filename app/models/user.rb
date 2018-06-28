class User < ApplicationRecord
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable,
         :timeoutable

  mount_uploader :document, ImageUploader
  mount_uploader :user_photo, ImageUploader
  belongs_to :bank
  
  has_many :addresses, dependent: :destroy
  has_one :local_address, dependent: :destroy
  has_one :permanent_address, dependent: :destroy

  has_one :account, dependent: :destroy

  has_and_belongs_to_many :beneficiaries

  has_many :transactions
  
  accepts_nested_attributes_for :local_address
  accepts_nested_attributes_for :permanent_address

  after_create :assign_default_role, :generate_account_no

  def assign_default_role
    self.add_role(:user) if self.roles.blank?
  end

  def generate_account_no
    Account.create!(account_no: (SecureRandom.random_number(9e11) + 1e11).to_i, user_id: self.id)
  end
end
