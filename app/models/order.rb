class Order < ActiveRecord::Base
  belongs_to :customer_address
  belongs_to :user
end
