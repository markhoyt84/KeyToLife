class Customer < ActiveRecord::Base
  has_one :customer_address
end
