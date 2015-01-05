class ShoppingCart < ActiveRecord::Base
  has_many :cart_items
  has_one :order
  has_one :user
end
