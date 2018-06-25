class User < ApplicationRecord
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  mount_uploader :document, ImageUploader
  mount_uploader :user_photo, ImageUploader
  belongs_to :bank
  
  has_many :addresses, dependent: :destroy
  has_one :local_address, dependent: :destroy
  has_one :permanent_address, dependent: :destroy

  has_one :account

  accepts_nested_attributes_for :local_address
  accepts_nested_attributes_for :permanent_address

  after_create :assign_default_role

  def assign_default_role
    self.add_role(:user) if self.roles.blank?
  end
end
