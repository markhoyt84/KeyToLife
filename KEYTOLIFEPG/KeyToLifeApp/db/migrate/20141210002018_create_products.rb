class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :name
      t.string :size
      t.string :sku
      t.decimal :Dist, :precision => 8, :scale => 2
      t.decimal :WS, :precision => 8, :scale => 2
      t.decimal :MSRP, :precision => 8, :scale => 2
      t.references :category
      t.references :description
      t.decimal :weight, :precision => 6, :scale => 2

      t.timestamps
    end
  end
end
