class CreateCustomerAddresses < ActiveRecord::Migration
  def change
    create_table :customer_addresses do |t|
      t.string :street1, :street2, :city, :state, :zip
      t.references :customer

      t.timestamps
    end
  end
end
