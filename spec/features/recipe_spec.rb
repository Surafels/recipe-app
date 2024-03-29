require 'rails_helper'

RSpec.describe 'Recipe', type: :feature do
  before(:each) do
    @user = User.create(name: 'New', email: 'user@gmail.com', password: '123456')
    @recipe = Recipe.create(name: 'Pizza', preparation_time: 3, cooking_time: 2, description: 'best pizza',
                            public: true, user_id: @user.id)
    @food = Food.create(name: 'Apple', measurment_unit: 'Kg', price: 100, quantity: 14, user_id: @user.id)
    @recipe_food = RecipeFood.create(quantity: 22, food_id: @food.id, recipe_id: @recipe.id)

    visit new_user_session_path
    fill_in 'Email', with: @user.email
    fill_in 'Password', with: @user.password
    click_button 'Log in'
  end

  describe 'recipe validation' do
    it 'should have remove button' do
      visit recipes_path
      expect(page).to have_content('Remove')
    end

    it 'should have recipe name' do
      visit recipes_path
      expect(page).to have_content('Pizza')
    end
  end
end
