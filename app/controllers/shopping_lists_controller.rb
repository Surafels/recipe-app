class ShoppingListsController < ApplicationController
  def index
    load_user_foods
    update_foods_quantity
    calculate_total_price
  end

  private

  def load_user_foods
    # Get all the foods of the current user with eager loading
    @foods = current_user.foods
  end

  def update_foods_quantity
    # Loop through each recipe and update the quantity of the foods
    current_user.recipes.each do |recipe|
      recipe.recipe_foods.each do |recipe_food|
        update_food_quantity(recipe_food)
      end
    end
  end

  def update_food_quantity(recipe_food)
    food = recipe_food.food
    selected_food = @foods.find { |f| f.name == food.name }

    # Update the quantity of the selected_food based on the recipe
    selected_food.quantity -= recipe_food.quantity if selected_food
  end

  def calculate_total_price
    # Calculate the total price of all foods, not just the selected ones
    @total = @foods.sum { |food| food.price * food.quantity }
  end
end
