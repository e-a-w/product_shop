class CreateCategoryTable < ActiveRecord::Migration[7.0]
  def up
    create_table :categories, if_not_exists: true do |t|
      t.string :name, null: false, limit: 50
      t.integer :department, null: false, default: 0
      t.integer :discount_percent, null: false, default: 0

      t.timestamps
    end
  end

  def down
    drop_table :categories, if_exists: true
  end
end
