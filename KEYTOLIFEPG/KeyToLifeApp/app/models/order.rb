class Order < ActiveRecord::Base
  has_one :shopping_cart
  has_one :user
end
