class CreateCartItems < ActiveRecord::Migration
  def change
    create_table :cart_items do |t|
      t.string :name
      t.string :size
      t.string :sku
      t.float :price
      t.references :category
      t.references :description
      t.references :shopping_cart

      t.timestamps
    end
  end
end
