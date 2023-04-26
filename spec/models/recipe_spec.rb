require 'spec_helper'

RSpec.describe Recipe, type: :model do
  describe 'associations' do
    let(:user) { User.create(name: 'John Doe') }
    let(:recipe) { Recipe.new(user: user) }

    it { should belong_to(:user) }
    it { should have_many(:recipe_foods) }
    it { should have_many(:foods).through(:recipe_foods) }
  end

  describe 'validations' do
    let(:recipe) { Recipe.new }

    it 'requires a name' do
      expect(recipe).not_to be_valid
      expect(recipe.errors[:name]).to include("can't be blank")
    end

    it 'requires a user' do
      recipe.name = 'Chicken Tikka'
      expect(recipe).not_to be_valid
      expect(recipe.errors[:user]).to include('must exist')
    end
  end
end
