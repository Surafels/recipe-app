class AddRecipeFoodsCountToRecipes < ActiveRecord::Migration[6.0]
  def change
    add_column :recipes, :recipe_foods_count, :integer, default: 0
  end
end
