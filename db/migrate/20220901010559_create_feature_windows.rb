class CreateFeatureWindows < ActiveRecord::Migration[7.0]
  def up
    create_table :feature_windows, if_exists: false do |t|
      t.references :product, null: false
      t.boolean :featured, null: false, default: false
      t.datetime :start_date, null: false
      t.datetime :end_date, null: false

      t.timestamps
    end
  end

  def down 
    drop_table :feature_windows, if_exists: true
  end
end
