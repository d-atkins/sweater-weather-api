class User < ApplicationRecord
  validates :email, uniqueness: true, presence: true
  validates :api_key, uniqueness: true
  validates_presence_of :password_confirmation

  has_secure_password
  has_secure_token :api_key
end
