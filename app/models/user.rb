class User < ActiveRecord::Base
  has_secure_password
  has_many :reviews
  validates :email, presence: true
end
