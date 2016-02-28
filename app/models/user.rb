class User < ActiveRecord::Base
  has_one :wedding
  has_secure_password
  validates_presence_of :username, :email

end