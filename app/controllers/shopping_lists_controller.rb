class ShoppingListsController < ApplicationController
  def index
    # Get all the foods of the current user with eager loading
    @foods = current_user.foods.includes(:recipes, :recipe_foods)

    # Loop through each recipe and update the quantity of the foods
    current_user.recipes.each do |recipe|
      recipe.recipe_foods.each do |recipe_food|
        food = recipe_food.food
        selected_food = @foods.find { |f| f.name == food.name }

        # Update the quantity of the selected_food based on the recipe
        selected_food.quantity -= recipe_food.quantity if selected_food
      end
    end

    # Select only the foods with negative quantity
    @selected_foods = @foods.select { |food| food.quantity.negative? }

    # Invert the quantity of the selected foods
    @selected_foods.each { |food| food.quantity *= -1 }

    # Calculate the total price of the selected foods
    @total = @selected_foods.sum { |food| food.price * food.quantity }
  end
end
