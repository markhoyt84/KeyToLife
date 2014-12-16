class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :name
      t.string :sku
      t.string :size
      t.float :Dist
      t.float :WS
      t.float :MSRP
      t.references :category

      t.timestamps
    end
  end
end
