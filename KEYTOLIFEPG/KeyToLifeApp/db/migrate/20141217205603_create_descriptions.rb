class CreateDescriptions < ActiveRecord::Migration
  def change
    create_table :descriptions do |t|
      t.string :range
      t.string :headline
      t.text :description
      t.text :directions
      t.string :derived
      t.string :ingredient
      t.string :love

      t.timestamps
    end
  end
end
