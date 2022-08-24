class CreateProductsTable < ActiveRecord::Migration[7.0]
  def change
    create_table :products do |t|
      t.string :name, null: false, limit: 50
      t.string :description, limit: 200
      t.integer :price, null: false, default: 0
      t.integer :quantity, null: false, default: 0
      t.datetime :last_sold_at

      t.timestamps
    end
  end
end
