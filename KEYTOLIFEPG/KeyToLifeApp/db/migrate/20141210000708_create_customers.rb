class CreateCustomers < ActiveRecord::Migration
  def change
    create_table :customers do |t|
      t.string :firstname, :lastname, :email, :phone_number
      t.timestamps
    end
  end
end
