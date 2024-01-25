class RecipesController < ApplicationController
  before_action :set_recipe, only: %i[show edit update destroy]

  # GET /recipes or /recipes.json
  def index
    # @recipes = Recipe.all
    @recipes = current_user.recipes
  end

  # GET /recipes/1 or /recipes/1.json
  def show
    @recipes = Recipe.find(params[:id])
  end

  # GET /recipes/new
  def new
    @recipe = Recipe.new
    @user = current_user
  end

  # GET /recipes/1/edit
  def edit; end

  def create
    @recipe = Recipe.new(recipe_params)

    # Extract steps from the steps_container
    steps = params[:recipe][:steps_attributes]

    # Process steps and add them to the recipe
    if steps
      steps.each do |index, step_attributes|
        @recipe.steps.build(description: step_attributes[:description])
      end
    end

    if @recipe.save
      redirect_to @recipe, notice: 'Recipe was successfully created.'
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
    @recipe.destroy!

    respond_to do |format|
      format.html { redirect_to recipes_url, notice: 'Recipe was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def add_step
    @step = Step.new(step_params)
    if @step.save
      render json: { status: 'success' }
    else
      render json: { status: 'error', errors: @step.errors.full_messages }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_recipe
    @recipe = Recipe.find(params[:id])
  end

  def step_params
    params.require(:step).permit(:description, :recipe_id)
  end

  # Only allow a list of trusted parameters through.
  def recipe_params
    params.require(:recipe).permit(
      :name, :preparation_time, :cooking_time, :description, :public,
      steps_attributes: [:description, :_destroy]
    )
  end
end
