module ApplicationHelper
  def calculate_total_price(recipe)
    
    recipe.recipe_foods.sum { |rf| rf.quantity * rf.food.price }
    end
end
