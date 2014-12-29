class CreateShoppingCarts < ActiveRecord::Migration
  def change
    create_table :shopping_carts do |t|
      t.integer :item_count, default: 0
      t.string :customer_id
      t.float :total
      t.float :taxes
      t.float :shipping, default: 0
      t.boolean :purchased, default: false

      t.timestamps
    end
  end
end
