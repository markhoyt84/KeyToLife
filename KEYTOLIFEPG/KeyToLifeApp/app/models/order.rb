class Order < ActiveRecord::Base
  has_one :shopping_cart
  has_one :user
  has_many :order_notes

  def create_stripe_token(charge)
    @temp_token = Stripe::Token.create(
          :card => {
          :number => charge['card_num'],
          :exp_month => charge['exp_month'],
          :exp_year => charge['exp_year'],
          :cvc => charge['cvc']
        })
  end

  def get_quote(weight)
    to_xml(weight)
    @response = HTTParty.post("http://uone-price.unishippers.com/price/pricelink", :body => @output)
    p '^' * 100
    p @response
    p '^' * 100
  end

  def get_box(weight)
    @box = {}
    if weight < 20
      @box['length'] = 12
      @box['width'] = 12
      @box['height'] = 8
    elsif weight < 30
      @box['length'] = 12
      @box['width'] = 12
      @box['height'] = 12
    else
      @box['length'] = 25
      @box['width'] = 12
      @box['height'] = 10
    end
    @box
  end

  def to_xml(weight)
    get_box(weight)
    date = Time.now.strftime("%Y-%m-%d")
    @output = "<?xml version=\"1.0\" encoding=\"UTF-8\"?><unishippersdomesticraterequest><username>keytolife</username><password>AGL80205</password><requestkey>5</requestkey> <unishipperscustomernumber>U13894304551</unishipperscustomernumber> <upsaccountnumber>8958R2</upsaccountnumber> <service>SG</service><packagetype>P</packagetype> <weight>" + "#{weight}" + "</weight> <length>" + "#{@box['length']}" +"</length> <width>" + "#{@box['width']}" + "</width> <height>" + "#{@box['height']}" + "</height> <declaredvalue>" + "#{self.total}" + "</declaredvalue> <shipdate>" + "#{date}" + "</shipdate><senderstate>CO</senderstate> <sendercountry>US</sendercountry> <senderzip>80205</senderzip> <receiverstate>" + "#{self.shipping_address_state}" + "</receiverstate> <receivercountry>US</receivercountry> <receiverzip>" + "#{self.shipping_address_zip}" + "</receiverzip></unishippersdomesticraterequest>"
    p @output
  end

  def get_tax(zip_code)
    num = zip_code.to_i
    if num >= 80001 && num <= 81658
      self.tax = (self.total / 100) * 7.62
      @tax = self.tax
      self.save
    end
    @tax
  end

  def get_grand_total(zip_code)
    get_tax(zip_code)
    total = self.total
    if @tax
      @grand_total = total += @tax
      self.grand_total = @grand_total
      self.save
    end
    puts self.total
    puts @grand_total
  end
end


# curl -d "<unishippersdomesticraterequest><username>keytolife</username><password>AGL80205</password><requestkey>2.0 Test Request</requestkey> <unishipperscustomernumber>U13894304551</unishipperscustomernumber> <upsaccountnumber>8958R2</upsaccountnumber> <service>SG</service><packagetype>P</packagetype> <weight>6</weight> <length>12</length> <width>12</width> <height>8</height> <declaredvalue>385.3</declaredvalue> <shipdate>2015-01-13</shipdate><senderstate>CO</senderstate> <sendercountry>US</sendercountry> <senderzip>80205</senderzip> <receiverstate>CO</receiverstate> <receivercountry>US</receivercountry> <receiverzip>81521</receiverzip></unishippersdomesticraterequest>" "http://uone-price.unishippers.com/price/pricelink"