require 'rails_helper'

RSpec.describe "Public recipes page", type: :feature do
    include Devise::Test::IntegrationHelpers

    let!(:user1) { User.create!(name: "Tom", email: "tom@gmail.com", password: "password") }
    let!(:user2) { User.create!(name: "John", email: "john@gmail.com", password: "password") }
    let!(:recipe1) { Recipe.create!(user: user1, name: "Chicken and Rice", preparation_time: 30, cooking_time: 60, description: "A classic dish that is easy to make.", public: true) }
    let!(:recipe2) { Recipe.create!(user: user2, name: "Spaghetti Bolognese", preparation_time: 20, cooking_time: 40, description: "A family favorite.", public: true) }
    let!(:food1) { Food.create!(name: "Chicken", user: user1, price: 10, quantity: 5, measurement_unit: 'grams') }
    let!(:food2) { Food.create!(name: "Rice", user: user1, price: 10, quantity: 2, measurement_unit: 'kilograms') }
    let!(:recipe_food1) { RecipeFood.create!(recipe: recipe1, food: food1, quantity: 500) }
    let!(:recipe_food2) { RecipeFood.create!(recipe: recipe1, food: food2, quantity: 1000) }


    before do
        sign_in user1
        visit public_recipes_path
    end

    describe 'Page content' do 
        it 'should display names of all public recipes' do 
            expect(page).to have_content(recipe1.name)
            expect(page).to have_content(recipe2.name)
        end

        it 'should display total food items for each recipe' do 
            expect(page).to have_content("Total foods items: #{recipe1.foods.count}")
            expect(page).to have_content("Total foods items: #{recipe2.foods.count}")
        end

        it 'should display total value for each recipe' do 
            expect(page).to have_content("Total price: $15,000.00")
            expect(page).to have_content("Total price: $0.00")
        end
    end

    describe "Clicking on a recipe" do 
        it 'should redirect to the correct recipe#show page' do 
            click_link recipe1.name 
            expect(current_path).to eq recipe_path(recipe1)
        end
    end
end
    