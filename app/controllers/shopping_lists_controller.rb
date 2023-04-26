class ShoppingListsController < ApplicationController 
  def index 
      # Select all recipes of current user
      @recipes = Recipe.includes(:foods).where(user_id: current_user.id)
      @food_quantities_by_name = @recipes[0].food_quantities_by_name
      @shopping_list = {}

      @recipes.each do |recipe|
          recipe.foods.each do |food|
              # Initialize food data if not in shopping list yet
              @shopping_list[food.name] ||= { name: food.name, quantity: 0, measurement_unit: food.measurement_unit, price: food.price, value: 0 }
              
              # Sum all the quantity from recipe
              @shopping_list[food.name][:quantity] += recipe.food_quantities_by_name[food.name]
          end 
      end
      # Select foods of current user
      @foods = current_user.foods 

      # Reduce quantity to buy if already present
      @shopping_list.each do |food_name, food|
          own_food = @foods.find_by(name: food_name)
          
          food[:quantity] -= own_food.quantity if own_food
          
          
          food[:value] = food[:quantity] * food[:price]
      end

      @food_types = @shopping_list.values.select {|i| i[:quantity] > 0 }.length
      @total_value = @shopping_list.values.map {|i| i[:value]}.sum
  end
end