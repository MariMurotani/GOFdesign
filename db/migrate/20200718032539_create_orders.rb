class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.integer :account_id, null: :false
      t.integer :delivery_method, limit: 3
      t.integer :payment_method, limit: 3
      t.integer :quantity
      t.timestamps
    end
  end
end
