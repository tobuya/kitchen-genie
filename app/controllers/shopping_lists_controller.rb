class ShoppingListsController < ApplicationController
  before_action :authenticate_user!

  def index
    # Select all recipes of current user 
    @recipes = Recipe.includes(:foods).where(user_id: current_user.id)
    @shopping_list = {}

    @recipes.each do |recipe|
      recipe.foods.select('DISTINCT on (name) *').each do |food|
        # Initialize food data if not in shopping list yet
        @shopping_list[food.name] ||= { name: food.name, quantity: 0, measurement_unit: food.measurement_unit,
                                        price: food.price, value: 0 }

        # Sum all the quantity from recipe
        @shopping_list[food.name][:quantity] += recipe.food_quantities_by_name[food.name]
      end
    end

    # Reduce quantity to buy if already present
    @shopping_list.each do |food_name, food|
      own_food = current_user.foods.find_by(name: food_name)
      food[:quantity] -= own_food.quantity if own_food
      food[:value] = food[:quantity] * food[:price]
    end

    @food_types = @shopping_list.values.select { |i| (i[:quantity]).positive? }.length
  end
end
