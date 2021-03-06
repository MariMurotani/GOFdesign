class CreateOperations < ActiveRecord::Migration[5.2]
  def change
    create_table :operations do |t|
      t.string :name
      t.integer :sub_type, null: false, limit: 3
      t.index :name
      t.index :sub_type
      t.timestamps
    end
  end
end
