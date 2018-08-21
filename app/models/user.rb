class User < ActiveRecord::Base
  has_many :notes
  validates :username, uniqueness: true

  has_secure_password
end
