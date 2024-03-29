class Ability
  include CanCan::Ability

  def initialize(user)
    can :public_recipes, Recipe
    can :read, Recipe, public: true

    return unless user.present?

    can :manage, Food, user_id: user.id
    can :manage, Recipe, user_id: user.id
    can :manage, RecipeFood, recipe: { user_id: user.id }
  end
end
