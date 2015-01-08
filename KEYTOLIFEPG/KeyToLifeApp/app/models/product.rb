class Product < ActiveRecord::Base
  belongs_to :category
  belongs_to :description
  has_many :photos, :as => :photoable

  def get_related
    brewer = Product.find(102)
    @related = []
    prod = Product.where('size' => '2 oz.')
    2.times do
      i = rand(1...prod.length - 1)
      @related << prod[i]
    end
    @related << brewer
  end
end
