# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
a1 = Account.new_user('SYSTEM')
a1.attributes =	({
  name: "System User",
  password: "system"
})
a1.save

a2 = Account.new_user('ADMIN')
a2.attributes =	({
  name: "Test Admin",
  password: "admin",
  email: "test@com",
  tel: "000999990000"
})
a2.save

a3 = Account.new_user('SHOPPER')
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
  sub_type:1,
  name: "admin dashboard",
})

product = Product.create({
  name: "テスト商品",
  description: "テスト商品の説明",
  ec_stock_id: 1,
  store_stock_id: 3
})

stock = Stock.create({
  product_id: product.id,
  ec_stock_amount: 3,
  store_stock_amount: 1
})