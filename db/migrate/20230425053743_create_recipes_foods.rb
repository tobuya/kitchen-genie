class CreateRecipesFoods < ActiveRecord::Migration[7.0]
  def change
    create_table :recipes_foods do |t|
      t.references :recipe, null: false, foreign_key: true
      t.references :food, null: false, foreign_key: true
      t.integer :quantity

      t.timestamps
    end
  end
end
