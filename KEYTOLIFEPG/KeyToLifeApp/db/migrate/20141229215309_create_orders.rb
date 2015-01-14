class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.references :shopping_cart
      t.references :user, :default => 'guest'
      t.decimal :total, :precision => 8, :scale => 2
      t.decimal :shipping_cost, :precision => 8, :scale => 2, :default => 0
      t.decimal :tax, :precision => 8, :scale => 2, :default => 0
      t.decimal :grand_total, :precision => 8, :scale => 2
      t.string :status, :default => 'Processing'
      t.string :email
      t.string :stripe_customer_id
      t.string :first_name, :last_name, :company, :billing_address, :billing_address_city, :billing_address_state, :billing_address_zip, :shipping_address, :shipping_address_city, :shipping_address_state, :shipping_address_zip, :telephone

      t.timestamps
    end
  end
end
