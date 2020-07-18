class CreateOrderedProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :ordered_products do |t|
      t.integer :order_id, null: :false
      t.integer :product_id, null: :false
      t.integer :quantity, limit: 5
      t.date :expected_delivery_date
      t.timestamps
    end
  end
end
