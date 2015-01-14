class CreateGreenideas < ActiveRecord::Migration
  def change
    create_table :greenideas do |t|
      t.text :body
      t.string :email
      t.string :name

      t.timestamps
    end
  end
end
