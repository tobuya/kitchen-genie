class RecipesController < ApplicationController
  before_action :authenticate_user!

  def index
    @recipes = current_user.recipes.all
  end

  def show 
    @recipe = Recipe.find(params[:id])
  end

  def new 
    @recipe = Recipe.new 
  end

  def create
    @recipe = Recipe.new(recipe_params)
    @recipe.user = current_user
    
    if @recipe.save
      flash[:success] = "Recipe created successfully!"
      redirect_to recipe_path(@recipe)
    else
      flash[:error] = "An error occurred! Please try again."
      render :new
    end
  end
  
  private
  
  def recipe_params
    params.require(:recipe).permit(:name, :preparation_time, :cooking_time, :description, :public)
  end
  
end
