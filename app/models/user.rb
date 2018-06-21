class User < ApplicationRecord
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  mount_uploader :document, ImageUploader
  mount_uploader :user_photo, ImageUploader
  belongs_to :bank

  has_many :addresses
  has_one :local_address
  has_one :permanent_address

  accepts_nested_attributes_for :local_address
  accepts_nested_attributes_for :permanent_address

end
