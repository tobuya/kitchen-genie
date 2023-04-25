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
recipe3 = Recipe.create!(user_id: user1.id, name: "Spaghetti and Meatballs", preparation_time: 30, cooking_time: 45, description: "A classic Italian dish that's always a crowd-pleaser.", public: true)
recipe4 = Recipe.create!(user_id: user1.id, name: "Beef Stir-Fry", preparation_time: 20, cooking_time: 10, description: "A quick and easy stir-fry recipe that's perfect for a weeknight meal.", public: true)
recipe5 = Recipe.create!(user_id: user1.id, name: "Salmon with Lemon and Dill", preparation_time: 10, cooking_time: 15, description: "A healthy and delicious seafood dish that's perfect for summer.", public: true)

# Associate foods with recipes
RecipeFood.create!(recipe: recipe1, food: food1, quantity: 400)
RecipeFood.create!(recipe: recipe2, food: food2, quantity: 800)
RecipeFood.create!(recipe: recipe1, food: food3, quantity: 500)
RecipeFood.create!(recipe: recipe3, food: food1, quantity: 300)
RecipeFood.create!(recipe: recipe3, food: food2, quantity: 500)

