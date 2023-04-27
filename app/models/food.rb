class Food < ApplicationRecord
  belongs_to :user
  has_many :recipe_foods, dependent: :destroy
  has_many :recipes, through: :recipe_foods, source: :recipe

  validates :name, presence: true
  validates :price, presence: true
  validates :measurement_unit, presence: true
  validates :quantity, presence: true
end
