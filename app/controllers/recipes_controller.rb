class RecipesController < ApplicationController
    before_action :authenticate_user!

    def index 
        @recipes = current_user.recipes.all 
    end
end
