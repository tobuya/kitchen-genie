require 'rails_helper'

RSpec.describe 'Shopping list page', type: :feature do
  include Devise::Test::IntegrationHelpers

  let!(:user) { User.create!(name: 'Tom', email: 'tom@gmail.com', password: 'password') }
  let!(:food1) { Food.create!(name: 'Chicken', user: user, price: 10, quantity: 5, measurement_unit: 'grams') }
  let!(:food2) { Food.create!(name: 'Rice', user: user, price: 10, quantity: 2, measurement_unit: 'kilograms') }
  let!(:recipe) do
    Recipe.create!(user: user, name: 'Chicken and Rice', preparation_time: 30, cooking_time: 60,
                   description: 'A classic dish that is easy to make.', public: true)
  end
  let!(:recipe_food1) { RecipeFood.create!(recipe: recipe, food: food1, quantity: 10) }
  let!(:recipe_food2) { RecipeFood.create!(recipe: recipe, food: food2, quantity: 2) }

  before do
    sign_in user
    visit shopping_list_path
  end

  describe 'Page content' do
    it 'should display necessary foods to buy' do
      expect(page).to have_content(food1.name)
    end

    it 'should display amount of items to buy' do
      expect(page).to have_content('1 Food Type To Buy')
    end

    it 'should display total value of items' do
      expect(page).to have_content("Total Value: $ #{(recipe_food1.quantity - food1.quantity) * food1.price}")
    end
  end
end
