class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :name
      t.string :size
      t.string :sku
      t.float :Dist
      t.float :WS
      t.float :MSRP
      t.references :category
      t.references :description

      t.timestamps
    end
  end
end
