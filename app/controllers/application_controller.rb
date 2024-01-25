class ApplicationController < ActionController::Base
  # before_action :authenticate_user!

    before_action :set_current_ability


  private

  def redirect_to_public_recipes
    redirect_to public_recipes_index_path if request.path == root_path
  end

   def set_current_ability
    @current_ability = Ability.new(current_user)
  end
end
