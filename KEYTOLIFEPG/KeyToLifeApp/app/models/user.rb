class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :user_addresses
  has_many :shopping_carts
  has_many :orders

  def retrieve_card_last_4_digit
    @card = Stripe::Customer.retrieve(self.stripe_customer_id).cards.all.first
    @card["last4"]
  end

  def create_stripe_customer(token)
    @customer = Stripe::Customer.create(
              :email => self.email,
              :card  => token['id']
              )
    self.stripe_customer_id = @customer['id']
    self.save
  end
end
