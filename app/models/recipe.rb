class Recipe < ApplicationRecord
  belongs_to :user
  has_many :recipe_foods, dependent: :destroy
  has_many :foods, through: :recipe_foods, source: :food

  def food_quantities_by_name 
    recipe_foods.joins(:food).group('foods.name').sum(:quantity)
  end

end
