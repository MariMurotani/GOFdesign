class CreateProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :products do |t|
      t.string :name
      t.string :description
      t.binary :picture
      t.integer :ec_stock_id, null: :false
      t.integer :store_stock_id, null: :false
      t.timestamps
    end
  end
end
