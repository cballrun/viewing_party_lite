
class User < ApplicationRecord
  
  validates_presence_of :email
  validates_uniqueness_of :email
  validates_presence_of :name
  validates_presence_of :password

  has_many :user_parties
  has_many :parties, through: :user_parties
  has_secure_password
  
end