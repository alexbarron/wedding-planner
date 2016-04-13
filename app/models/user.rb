class User < ActiveRecord::Base
  has_one :wedding
  has_many :guests, through: :wedding
  has_many :vendors, through: :wedding
  has_secure_password
  validates_presence_of :username, :email

end