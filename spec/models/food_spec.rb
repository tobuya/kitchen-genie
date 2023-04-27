require 'spec_helper'

RSpec.describe Food, type: :model do
  describe 'associations' do
    it { should belong_to(:user) }
    it { should have_many(:recipe_foods) }
    it { should have_many(:recipes).through(:recipe_foods).source(:recipe) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:price) }
    it { should validate_presence_of(:measurement_unit) }
    it { should validate_presence_of(:quantity) }
  end
end
