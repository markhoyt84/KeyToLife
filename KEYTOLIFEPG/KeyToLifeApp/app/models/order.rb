class Order < ActiveRecord::Base
  has_one :shopping_cart
  has_one :user
  has_many :order_notes
  @unishipper_username = ENV['UNISHIPPER_USERNAME']
  @unishipper_password = ENV['UNISHIPPER_PASSWORD']

  def create_stripe_token(charge)
    @temp_token = Stripe::Token.create(
          :card => {
          :number => charge['card_num'],
          :exp_month => charge['exp_month'],
          :exp_year => charge['exp_year'],
          :cvc => charge['cvc']
        })
  end

  def to_xml
    date = Time.now.strftime("%Y-%m-%d")
    @output = "<unishippersdomesticraterequest><username>" + "#{@unishipper_username}" + "</username><password>" + "#{@unishipper_username}" + "</password><requestkey>2.0 Test Request</requestkey> <unishipperscustomernumber>U1236822371</unishipperscustomernumber> <upsaccountnumber>123UPS</upsaccountnumber> <service>SG</service><packagetype>P</packagetype> <weight>" + "#{ self.weight }" + "</weight> <length>" + "#{@box.length}" +"</length> <width>" + "#{@box.width}" + "</width> <height>" + "#{@box.height}" + "</height> <declaredvalue>" + "#{self.total}" + "</declaredvalue> <shipdate>" + "#{date}" + "</shipdate><senderstate>CO</senderstate> <sendercountry>US</sendercountry> <senderzip>80205</senderzip> <receiverstate>" + "#{self.shipping_address_state}" + "</receiverstate> <receivercountry>US</receivercountry> <receiverzip>" + "#{self.shipping_address_zip}" + "</receiverzip></unishippersdomesticraterequest>"
    p @output
  end
end
