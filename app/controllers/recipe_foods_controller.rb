class RecipeFoodsController < ApplicationController
  def new
    @foods = Food.all
    @recipe = Recipe.find(params[:recipe_id])
  end

  def create
    @recipe_food = RecipeFood.new(recipe_food_params)
    @recipe = Recipe.find(params[:recipe_id])
    @recipe_food.recipe = @recipe

    return unless @recipe_food.save

    flash[:success] = 'New ingredient added successfully!'
    redirect_to recipe_path(@recipe)
  end

  def destroy
    @recipe_food = RecipeFood.find(params[:id])
    @recipe_food.destroy

    flash[:alert] = 'Removed an ingredient!'
    redirect_to recipe_path(@recipe_food.recipe)
  end

  private

  def recipe_food_params
    params.require(:recipe_food).permit(:food_id, :quantity)
  end
end
