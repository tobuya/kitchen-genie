class RecipeFood < ApplicationRecord
  self.table_name = 'recipes_foods'

  belongs_to :recipe
  belongs_to :food
end
