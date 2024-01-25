class RecipesController < ApplicationController
  before_action :set_recipe, only: %i[show edit update destroy]
  # GET /recipes or /recipes.json
  def index
    # @recipes = Recipe.all
    @recipes = current_user.recipes
  end

  # GET /recipes/1 or /recipes/1.json
  def show
    @recipe = Recipe.find(params[:id])
    authorize! :read, @recipe
  end

  # GET /recipes/new
  def new
    @recipe = Recipe.new
    @recipe.steps.build # Build an empty step for the form
    @user = current_user
  end

  # GET /recipes/1/edit
  def edit; end

  def create
    @recipe = current_user.recipes.build(recipe_params)

    if @recipe.save
      redirect_to recipes_path, notice: 'Recipe was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /recipes/1 or /recipes/1.json
  def update
    respond_to do |format|
      if @recipe.update(recipe_params)
        format.html { redirect_to recipe_url(@recipe), notice: 'Recipe was successfully updated.' }
        format.json { render :show, status: :ok, location: @recipe }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @recipe.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /recipes/1 or /recipes/1.json
  def destroy
    @recipe = Recipe.find(params[:id])
    @recipe.destroy
    redirect_to recipes_path, notice: 'Recipe eliminated successfully.'
  end

  def add_ingredient
    @recipe = Recipe.find(params[:id])
    @food = Food.new
    @foods = Food.all
  end

  def save_ingredient
    @recipe = Recipe.find(params[:id])
    @food = Food.find(params[:food_id])
    quantity = params[:quantity].to_i

    if @food && quantity.positive?
      # Calculate the value based on the unit price and quantity
      value = @food.price * quantity

      # Create a temporary ingredient hash and store it in the session
      temp_ingredient = {
        food_name: @food.name,
        quantity:,
        value:
      }

      session[:temp_ingredient] ||= []
      session[:temp_ingredient] << temp_ingredient

      flash[:notice] = 'Ingredient was successfully added.'
      redirect_to add_ingredient_recipe_path(@recipe)
    else
      flash[:alert] = 'Invalid food or quantity.'
      render :add_ingredient
    end
  end

  def remove_temp_ingredient
    index = params[:index].to_i
    session[:temp_ingredient].delete_at(index) if index >= 0

    redirect_to recipe_path(@recipe), notice: 'Ingredient was successfully removed.'
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_recipe
    @recipe = Recipe.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def recipe_params
    params.require(:recipe).permit(
      :name, :preparation_time, :cooking_time, :description, :public, :user_id,
      recipe_foods_attributes: %i[id food quantity value _destroy]
    )
  end

  def food_params
    params.require(:food).permit(:name, :price, :measurement_unit)
  end
end
