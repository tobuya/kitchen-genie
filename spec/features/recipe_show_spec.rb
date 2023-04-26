require 'rails_helper'

RSpec.describe 'Recipe show page', type: :feature do
  include Devise::Test::IntegrationHelpers

  let!(:user) { User.create!(name: 'Jane', email: 'jane@gmail.com', password: 'password') }
  let!(:recipe) do
    Recipe.create!(user: user, name: 'Chicken and Rice', preparation_time: 30, cooking_time: 60,
                   description: 'A classic dish that is easy to make.', public: true)
  end


  before do
    sign_in user
    visit recipe_path(recipe)
  end

  describe 'Page content' do
    it 'should display the recipe name' do
      expect(page).to have_content(recipe.name)
    end

    it 'should display the recipe description' do
      expect(page).to have_content(recipe.description)
    end

    it 'should display the recipe preparation time' do
      expect(page).to have_content(recipe.preparation_time)
    end

    it 'should display the recipe cooking time' do
      expect(page).to have_content(recipe.cooking_time)
    end

    it 'should have a button to add ingredient' do
      expect(page).to have_link('Add Ingredient')
    end

    it 'should have a button to delete recipe' do
      expect(page).to have_button('Delete Recipe')
    end

    it 'should have a button to generate shopping list' do
      expect(page).to have_link('Generate Shopping List')
    end
  end

  describe 'Clicking button to add ingredient' do
    it 'should redirect to the recipe_food#new page' do
      click_link 'Add Ingredient'
      expect(current_path).to eq new_recipe_recipe_food_path(recipe)
    end
  end

  describe 'Clicking button to generate shopping list' do
    it 'should redirect to the shopping_list#index page' do
      click_link 'Generate Shopping List'
      expect(current_path).to eq shopping_list_path
    end
  end
end
