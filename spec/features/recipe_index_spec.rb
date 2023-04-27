require 'rails_helper'

RSpec.describe 'Recipe index page', type: :feature do
  include Devise::Test::IntegrationHelpers

  let!(:user) { User.create!(name: 'Jane', email: 'jane@gmail.com', password: 'password') }
  let!(:recipe1) do
    Recipe.create!(user: user, name: 'Chicken and Rice', preparation_time: 30, cooking_time: 60,
                   description: 'A classic dish that is easy to make.', public: true)
  end
  let!(:recipe2) do
    Recipe.create!(user: user, name: 'Spaghetti Bolognese', preparation_time: 20, cooking_time: 40,
                   description: 'A family favorite.', public: true)
  end

  before do
    sign_in user
    visit recipes_path
  end

  describe 'Page content' do
    it 'should display names of all recipes' do
      expect(page).to have_content(recipe1.name)
      expect(page).to have_content(recipe2.name)
    end

    it 'should have a button to add new recipe' do
      expect(page).to have_link('Create New Recipe')
    end

    it 'should have a button to delete recipe' do
      expect(page).to have_button('Remove')
    end

    it 'should display preparation times of all recipes' do
      expect(page).to have_content(recipe1.preparation_time)
      expect(page).to have_content(recipe2.preparation_time)
    end

    it 'should display cooking times of all recipes' do
      expect(page).to have_content(recipe1.cooking_time)
      expect(page).to have_content(recipe2.cooking_time)
    end

    it 'should display descriptions of all recipes' do
      expect(page).to have_content(recipe1.description)
      expect(page).to have_content(recipe2.description)
    end
  end

  describe 'Clicking button to add recipe' do
    it 'should redirect to recipe#new page' do
      click_link 'Create New Recipe'
      expect(current_path).to eq new_recipe_path
    end
  end
end
