class User < ActiveRecord::Base

  validates :name,  presence: true, length: { maximum: 2 }
  has_secure_password

end
