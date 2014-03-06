class User < ActiveRecord::Base

  has_many :applications

  validates :name, presence: true, length: { minimum: 2 }
  validates :email, presence: true, length: { minimum: 5 }
  validates :password, presence: true, length: { minimum: 6 }
  
end