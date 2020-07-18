# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
a1 = Account.new_user('ADMIN')
a1.name = "Test Admin"
a1.password = "aaaaaaa"
a1.save

b1 = Account.new_user('SHOPPER')
b1.name = "Shop Admin"
b1.password = "bbbbb"
b1.save

Operation.create({sub_type:1, name: "admin dashboard"})