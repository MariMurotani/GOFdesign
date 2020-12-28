class CreateAccounts < ActiveRecord::Migration[5.2]
  def change
    create_table :accounts do |t|
      t.string :name
      t.integer :account_type, null: false
      t.string :password
      t.string :email
      t.string :tel
      t.index :email
      t.index :tel
      t.timestamps
    end
  end
end
