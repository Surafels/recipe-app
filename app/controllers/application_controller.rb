class ApplicationController < ActionController::Base
  # before_action :authenticate_user!

  private

  def redirect_to_public_recipes
    redirect_to public_recipes_index_path if request.path == root_path
  end
end
