require 'rails_helper'

RSpec.describe "Foods", type: :request do
  include Devise::Test::IntegrationHelpers

  let!(:user) { User.create!(name: "Tom", email: "tom@gmail.com", password: "password") }
  let!(:food1) { Food.create!(name: "Chicken", user: user, price: 10, quantity: 5, measurement_unit: 'grams')}
  let!(:food2) { Food.create!(name: "Rice", user: user, price: 10, quantity: 2, measurement_unit: 'kilograms')}

  before do 
    sign_in user 
  end

  describe "GET /foods" do
    it "should return a 200 OK status" do
      get foods_path
      expect(response).to have_http_status(200)
    end

    it "should render foods/index template" do 
      get foods_path
      expect(response).to render_template("index")
    end

    it "should display list of foods" do 
      get foods_path
      expect(response.body).to include(food1.name)
      expect(response.body).to include(food2.name)
    end
  end
end
