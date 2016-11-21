class User < ActiveRecord::Base
  has_many :reviews
  has_secure_password validations: false

  validates_presence_of :username, :password, :email

  validates :email, uniqueness: true
end