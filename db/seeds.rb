# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require "#{Rails.root}/app/models/factories/abstract_factory.rb"
require "#{Rails.root}/app/models/factories/account_factory.rb"
a1 = AccountFactory.create('system')
a1.attributes =	({
  name: "System User",
  password: "system"
})
a1.save

a2 = AccountFactory.create('admin')
a2.attributes =	({
  name: "Test Admin",
  password: "admin",
  email: "test@com",
  tel: "000999990000"
})
a2.save

a3 = AccountFactory.create('shopper')
a3.attributes =	({
  name: "Shop Admin",
  password: "shop",
  email: "test@com",
  tel: "000999990000"
})
a3.save

address_new = Address.create(
  account: a3,
  postal_code: "1000000",
  street: "Test Street",
  city: "Test City",
  state: "Test State",
  country: "TestCounty",
)

Operation.create({
 sub_type: Operation.sub_types["admin"],
 name: "admin dashboard",
})

product = Product.create({
  name: "test 1",
  description: "test description 1",
  ec_stock_id: 1,
  store_stock_id: 3,
  price: 1000
})

stock = Stock.create({
  product_id: product.id,
  ec_stock_amount: 3,
  store_stock_amount: 1
})

product2 = Product.create({
   name: "test 2",
   description: "test description 2",
   ec_stock_id: 1,
   store_stock_id: 3,
   price: 1200
})

stock2 = Stock.create({
  product_id: product2.id,
  ec_stock_amount: 3,
  store_stock_amount: 1
})

# Execute after 4.1.2
UpdateStockInformationJob.new.perform