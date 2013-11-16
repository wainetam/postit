class User < ActiveRecord::Base
  has_many :posts
  has_many :comments

  has_secure_password validations: false
  validates :username, presence: true, uniqueness: true, length: { minimum: 2 }
  validates :password, presence: true, on: :create, length: { minimum: 3 }
end