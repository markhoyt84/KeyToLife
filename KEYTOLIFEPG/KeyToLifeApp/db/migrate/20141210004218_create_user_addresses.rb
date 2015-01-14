class CreateUserAddresses < ActiveRecord::Migration
  def change
    create_table :user_addresses do |t|
      t.string :street1, :street2, :city, :state, :zip
      t.references :user

      t.timestamps
    end
  end
end
