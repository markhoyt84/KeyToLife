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
    cost = hash_from_xml(@response)
    self.shipping_cost = cost
    self.save
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
    @output = "<?xml version=\"1.0\" encoding=\"UTF-8\"?><unishippersdomesticraterequest><username>keytolife</username><password>AGL80205</password><requestkey>5</requestkey> <unishipperscustomernumber>U13894304551</unishipperscustomernumber> <upsaccountnumber>8958R2</upsaccountnumber> <service>SG</service><packagetype>P</packagetype> <weight>" + "#{weight}" + "</weight> <length>" + "#{@box['length']}" +"</length> <width>" + "#{@box['width']}" + "</width> <height>" + "#{@box['height']}" + "</height> <cod>0</cod> <shipdate>" + "#{date}" + "</shipdate><senderstate>CO</senderstate> <sendercountry>US</sendercountry> <senderzip>80205</senderzip> <receiverstate>" + "#{self.shipping_address_state}" + "</receiverstate> <receivercountry>US</receivercountry> <receiverzip>" + "#{self.shipping_address_zip}" + "</receiverzip><fees></fees></unishippersdomesticraterequest>"
    p @output
  end

  def hash_from_xml(xml)
    result = Hash.from_xml(xml)
    a = result["unishippersdomesticrateresponse"]["rates"]
    b = a['rate']
    @shipping_cost = b['total']
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
    shipping = self.shipping_cost
    cost = total + shipping
    if @tax
      @grand_total = cost += @tax
      self.grand_total = @grand_total
      self.save
    else
      self.grand_total = cost
      self.save
    end
    p @grand_total
  end
end

# curl -d "<unishippersdomesticraterequest><username>keytolife</username><password>AGL80205</password><requestkey>2.0 Test Request</requestkey> <unishipperscustomernumber>U13894304551</unishipperscustomernumber> <upsaccountnumber>8958R2</upsaccountnumber> <service>SG</service><packagetype>P</packagetype> <weight>6</weight> <length>12</length> <width>12</width> <height>8</height> <cod>0</cod> <declaredvalue>385.3</declaredvalue> <shipdate>2015-01-13</shipdate><senderstate>CO</senderstate> <sendercountry>US</sendercountry> <senderzip>80205</senderzip> <receiverstate>CA</receiverstate> <receivercountry>US</receivercountry> <receiverzip>96158</receiverzip><fees></fees></unishippersdomesticraterequest>" "http://uone-price.unishippers.com/price/pricelink"