class ShoppingListsController < ApplicationController 
    def index 
        # Select all recipes of current user
        @recipes = Recipe.includes(:foods).where(user_id: current_user.id)
        @shopping_list = {}

        @recipes.each do |recipe|
            recipe.foods.each do |food|
                # Initialize food data if not in shopping list yet
                @shopping_list[food.id] ||= { name: food.name, quantity: 0, measurement_unit: food.measurement_unit, price: food.price, value: 0 }
                
                # Sum all the quantity from recipe
                @shopping_list[food.id][:quantity] += recipe.recipe_foods.find_by(food_id: food.id).quantity
            end 
        end
        # Select foods of current user
        @foods = current_user.foods 

        # Reduce quantity to buy if already present
        @shopping_list.each do |food_id, food|
            own_food = @foods.find_by(id: food_id)
            
            if own_food.present?
                food[:quantity] -= own_food.quantity
            end
            
            food[:value] = food[:quantity] * food[:price]
        end
    end
end