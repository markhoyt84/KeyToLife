class CreateOrderNotes < ActiveRecord::Migration
  def change
    create_table :order_notes do |t|
      t.text :notes
      t.references :order

      t.timestamps
    end
  end
end
