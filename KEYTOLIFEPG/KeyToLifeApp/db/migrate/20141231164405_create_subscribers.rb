class CreateSubscribers < ActiveRecord::Migration
  def change
    create_table :subscribers do |t|
      t.string :email
      t.string :name, :default => 'Subscriber'

      t.timestamps
    end
  end
end
