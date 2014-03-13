class User < ActiveRecord::Base

  validates :name,  presence: true, uniqueness: true, length: { maximum: 2 }
  validates :password, length: { minimum: 2 }
  has_secure_password

end
