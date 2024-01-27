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

    # Check if the current user is the owner of the recipe
    if @recipe.user == current_user
      @recipe.recipe_foods.destroy_all
      @recipe.destroy
      redirect_to recipes_path, notice: 'Recipe eliminated successfully.'
    else
      # If the current user is not the owner, handle unauthorized access
      redirect_to recipes_path, alert: 'You are not authorized to delete this recipe.'
    end
  end

  def add_ingredient
    @recipe = Recipe.find(params[:id])
    @food = Food.new
    @foods = Food.all
  end

  def toggle_public
    @recipe = Recipe.find(params[:id])
    @recipe.toggle!(:public)
    respond_to do |format|
      format.html { redirect_to @recipe, notice: 'Recipe was successfully updated.' }
      format.json { render :show, status: :ok, location: @recipe }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_recipe
    @recipe = Recipe.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def recipe_params
    params.require(:recipe).permit(:name, :preparation_time, :cooking_time, :description, :public,
                                   steps_attributes: [:description, :_destroy])
  end


  def food_params
    params.require(:food).permit(:name, :price, :measurement_unit)
  end
end
