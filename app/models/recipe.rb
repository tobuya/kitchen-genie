class Recipe < ApplicationRecord
  belongs_to :user
  has_many :recipe_foods
  has_many :foods, through: :recipe_foods, source: :food

  def food_count
    foods.count
  end

  def food_total_price
    foods.sum(:price)
  end
end
