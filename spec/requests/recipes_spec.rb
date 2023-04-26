require 'rails_helper'

RSpec.describe "Recipes", type: :request do
    include Devise::Test::IntegrationHelpers

    let!(:user1) { User.create!(name: "Tom", email: "tom@gmail.com", password: "password") }
    let!(:user2) { User.create!(name: "John", email: "john@gmail.com", password: "password") }
    let!(:recipe1) { Recipe.create!(user: user1, name: "Chicken and Rice", preparation_time: 30, cooking_time: 60, description: "A classic dish that is easy to make.", public: true) }
    let!(:recipe2) { Recipe.create!(user: user2, name: "Spaghetti Bolognese", preparation_time: 20, cooking_time: 40, description: "A family favorite.", public: true) }

    before do 
        sign_in user1 
    end

    describe 'GET /recipes' do 
        it 'should return a 200 OK status' do 
            get recipes_path 
            expect(response).to have_http_status(200)
        end
        
        it 'should render recipes/index template' do 
            get recipes_path
            expect(response).to render_template('index')
        end

        it 'should display list of recipes created by current user' do 
            get recipes_path
            expect(response.body).to include(recipe1.name)
            expect(response.body).to_not include(recipe2.name)
        end
    end 

    describe 'GET /recipes/:id' do 
        it 'should return a 200 OK status' do 
            get recipe_path(recipe1)
            expect(response).to have_http_status(200)
        end

        it 'should render recipes/show template' do 
            get recipe_path(recipe1)
            expect(response).to render_template('show')
        end

        it 'should display recipe details' do 
            get recipe_path(recipe1)
            expect(response.body).to include(recipe1.name)
            expect(response.body).to include(recipe1.description)
            expect(response.body).to include(recipe1.description)
        end
    end
end
    