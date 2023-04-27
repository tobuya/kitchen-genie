class PublicRecipesController < ApplicationController
  def index
    @recipes = Recipe.includes(:foods).where(public: true)
  end
end
