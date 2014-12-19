class Product < ActiveRecord::Base
  belongs_to :category
  belongs_to :description
  has_many :photos, :as => :photoable
end
