require 'rails_helper'

RSpec.describe "Food index page", type: :feature do
  include Devise::Test::IntegrationHelpers

  let!(:user) { User.create!(name: 'Jane', email: 'jane@gmail.com', password: 'password')}
  let!(:food1) { Food.create!(name: "Chicken", user: user, price: 10, quantity: 5, measurement_unit: 'grams')}
  let!(:food2) { Food.create!(name: "Rice", user: user, price: 10, quantity: 2, measurement_unit: 'kilograms')}
   
  before do 
    sign_in user 
    visit foods_path 
  end

  describe 'Page content' do 
    
    it 'should display names of all food' do 
      expect(page).to have_content(food1.name)
      expect(page).to have_content(food2.name)
    end

    it 'should have a button to add new food' do 
      expect(page).to have_link('Add Food')
    end

    it 'should have a button to delete food' do 
      expect(page).to have_button('Delete')
    end

    it 'should display prices of all food' do 
      expect(page).to have_content(food1.price)
      expect(page).to have_content(food2.price)
    end

    it 'should display quantities of all food' do 
      expect(page).to have_content(food1.quantity)
      expect(page).to have_content(food2.quantity)
    end

    it 'should display units of all food' do 
      expect(page).to have_content(food1.measurement_unit)
      expect(page).to have_content(food2.measurement_unit)
    end
  end

  describe 'Clicking button to add food' do 
    it 'should redirect to food#new page' do 
      click_link 'Add Food'
      expect(current_path).to eq new_food_path
    end
  end
end
