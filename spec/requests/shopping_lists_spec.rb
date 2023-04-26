require 'rails_helper'

RSpec.describe 'ShoppingLists', type: :request do
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
  end

  describe 'GET /shopping_list' do
    it 'should return a 200 OK status' do
      get shopping_list_path
      expect(response).to have_http_status(200)
    end

    it 'should render shopping_lists/index template' do
      get shopping_list_path
      expect(response).to render_template('index')
    end

    it 'should display a list of necessary foods to buy' do
      get shopping_list_path
      expect(response.body).to include(food1.name)
      expect(response.body).to_not include(food2.name)
    end
  end
end
