class RecipeFoodsController < ApplicationController
  before_action :set_recipe_food, only: [:update]

  def new
    @recipe_food = RecipeFood.new
  end

  def create
    @recipe_food = RecipeFood.new(recipe_food_params)
    @recipe_food.recipe_id = params[:recipe_id]
    if @recipe_food.save
      redirect_to recipe_path(params[:recipe_id]), notice: 'Ingredient was successfully added.'
    else
      render :new
    end
  end

  def destroy
    @recipe_food = RecipeFood.find(params[:id])
    @recipe_food.destroy
    redirect_to recipe_path(@recipe_food.recipe), notice: 'Ingredient was successfully removed.'
  end

  def edit
    @recipe_food = RecipeFood.find(params[:id])
  end

  def update
    @recipe = Recipe.find(params[:recipe_id])

    respond_to do |format|
      if @recipe_food.update(recipe_food_params)
        format.html do
          redirect_to recipe_recipe_food_url(@recipe, @recipe_food), notice: 'Recipe food was successfully updated.'
        end
        format.json { render :show, status: :ok, location: @recipe_food }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end


  private

  def set_recipe_food
    @recipe_food = RecipeFood.find(params[:id])
  end

  def recipe_food_params
    params.require(:recipe_food).permit(:food_id, :quantity)
  end
end
