class User < ActiveRecord::Base
  
  has_secure_password
  has_many :orders
  has_many :reviews

  validates :email, presence: true, confirmation: true, uniqueness: { case_sensitive: false }
  validates :email_confirmation, presence: true
  validates_format_of :email, with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, on: :create

  validates :password, presence: true, confirmation: true, length: { in: 6..20 }

  validates :last_name, presence: true
  validates :first_name, presence: true

  def self.authenticate_with_credentials(email,pass)
    email.downcase!
    email.strip!
    @user = User.find_by_email(email)
    (@user && @user.authenticate(pass)) ? @user : nil
  end

end
