class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :name
      t.string :sku
      t.string :description
      t.string :option
      t.string :quantity
      t.decimal :price, :precision => 10, :scale => 2
      t.references :category

      t.timestamps
    end
  end
end
