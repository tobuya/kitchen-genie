# Create some users
user1 = User.create!(name: "John", email: "john@example.com", password: "password123")
user2 = User.create!(name: "Jane", email: "jane@example.com", password: "password123")

# Create some foods
food1 = Food.create!(user_id: user1.id, name: "Chicken", measurement_unit: 1, price: 100, quantity: 500)
food2 = Food.create!(user_id: user1.id, name: "Rice", measurement_unit: 2, price: 50, quantity: 1000)
food3 = Food.create!(user_id: user2.id, name: "Beef", measurement_unit: 1, price: 150, quantity: 750)

# Create some recipes
recipe1 = Recipe.create!(user_id: user1.id,name: "Chicken and Rice", preparation_time: 30, cooking_time: 60, description: "A classic dish that's easy to make.", public: true)
recipe2 = Recipe.create!(user_id: user2.id,name: "Beef Stew", preparation_time: 45, cooking_time: 120, description: "A hearty and filling stew that's perfect for cold weather.", public: false)

# Associate foods with recipes
RecipeFood.create!(recipe: recipe1, food: food1, quantity: 400)
RecipeFood.create!(recipe: recipe2, food: food2, quantity: 800)
RecipeFood.create!(recipe: recipe1, food: food3, quantity: 500)
