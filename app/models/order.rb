class Order < ActiveRecord::Base
  has_one :customer_address
  belongs_to :user
end
