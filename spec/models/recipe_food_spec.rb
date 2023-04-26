require 'spec_helper'

RSpec.describe RecipeFood, type: :model do
  let(:recipe) { Recipe.create(name: 'Chicken Tikka') }
  let(:food) { Food.create(name: 'Pilau') }

  describe 'associations' do
    it { should belong_to(:food) }
    it { should belong_to(:recipe) }
  end

  describe 'validations' do
    it 'requires a recipe' do
      recipe_food = RecipeFood.create(food: food)
      expect(recipe_food).not_to be_valid
      expect(recipe_food.errors[:recipe]).to include('must exist')
    end

    it 'requires a food' do
      recipe_food = RecipeFood.create(recipe: recipe)
      expect(recipe_food).not_to be_valid
      expect(recipe_food.errors[:food]).to include('must exist')
    end
  end

  describe 'table name' do
    it 'has the correct table name' do
      expect(RecipeFood.table_name).to eq('recipes_foods')
    end
  end
end
