class Recipe < ApplicationRecord
  belongs_to :user
  has_many :recipe_foods
  has_many :foods, through: :recipe_foods, source: :food

  validates :name, presence: true

  def food_count
    foods.count
  end

  def food_total_price
    price = 0
    recipe_foods.each do |recipe_food|
      price += recipe_food.quantity * recipe_food.food.price
    end

    price
  end
end
