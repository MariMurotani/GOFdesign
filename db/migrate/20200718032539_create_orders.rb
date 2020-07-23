class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.belongs_to :account, null: :false
      t.integer :delivery_method, limit: 3
      t.integer :payment_method, limit: 3
      t.integer :quantity
      t.timestamps
    end
  end
end
