class AddQuantityToFoodsRecipes < ActiveRecord::Migration[7.0]
  def change
    add_column :foods_recipes, :quantity, :integer
  end
end
