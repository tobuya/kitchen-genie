require 'rails_helper'

RSpec.describe 'PublicRecipes', type: :request do
  let!(:user1) { User.create!(name: 'Tom', email: 'tom@gmail.com', password: 'password') }
  let!(:user2) { User.create!(name: 'John', email: 'john@gmail.com', password: 'password') }
  let!(:recipe1) do
    Recipe.create!(user: user1, name: 'Chicken and Rice', preparation_time: 30, cooking_time: 60,
                   description: 'A classic dish that is easy to make.', public: true)
  end
  let!(:recipe2) do
    Recipe.create!(user: user2, name: 'Spaghetti Bolognese', preparation_time: 20, cooking_time: 40,
                   description: 'A family favorite.', public: true)
  end

  describe 'GET /public_recipes' do
    it 'should return a 200 OK status' do
      get public_recipes_path
      expect(response).to have_http_status(200)
    end

    it 'should render the public_recipes/index template' do
      get public_recipes_path
      expect(response).to render_template('index')
    end

    it 'should display the public recipes' do
      get public_recipes_path
      expect(response.body).to include(recipe1.name)
      expect(response.body).to include(recipe2.name)
    end

    it 'should not display private recipes' do
      recipe1.update(public: false)
      get public_recipes_path
      expect(response.body).not_to include(recipe1.name)
    end
  end
end
