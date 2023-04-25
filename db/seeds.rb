# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
user = User.create(name: "John Doe")
Food.create(name: "Apple", measurement_unit: 1, price: 50, quantity: 100, user_id: user.id)
Food.create(name: "Orange", measurement_unit: 1, price: 75, quantity: 50, user_id: user.id)
Food.create(name: "Banana", measurement_unit: 1, price: 30, quantity: 200, user_id: user.id)
Food.create(name: "Potato", measurement_unit: 2, price: 20, quantity: 150, user_id: user.id)
