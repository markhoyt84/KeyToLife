class ShoppingCart < ActiveRecord::Base
  has_many :cart_items
  has_one :order
  has_one :user

  def get_total
    @total = 0.0
    self.cart_items.each do |item|
      @total += item.price
    end
    self.save
    self.total = @total
  end

  def get_weight
    start_weight = 0
    self.cart_items.each do |item|
      p '*' * 100
      start_weight += item.weight
      p item
      p '*' * 100

    end
    @weight = (start_weight / 16).to_i
  end
end
