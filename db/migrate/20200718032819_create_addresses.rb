class CreateAddresses < ActiveRecord::Migration[5.2]
  def change
    create_table :addresses do |t|
      t.belongs_to :account, null: :false
      t.string :postal_code
      t.string :street
      t.string :city
      t.string :state
      t.string :country
      t.string :string
      t.timestamps
    end
  end
end
