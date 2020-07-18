class CreateLogs < ActiveRecord::Migration[5.2]
  def change
    create_table :logs do |t|
      t.integer :operation_id, null: :false
      t.integer :account_id, null: :false
      t.string :description
      t.timestamps
    end
  end
end
