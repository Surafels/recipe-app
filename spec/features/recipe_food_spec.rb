require 'rails_helper'

RSpec.describe 'RecipeFood', type: :feature do
  before(:each) do
    @user = User.create(name: 'New', email: 'user@gmail.com', password: '123456')
    @recipe = Recipe.create(name: 'Chicken', preparation_time: 3, cooking_time: 2, description: 'Nice chicken',
                            public: true, user_id: @user.id)
    @food = Food.create(name: 'Rice', measurment_unit: 'Kg', price: 30, quantity: 10, user_id: @user.id)
    @recipe_food = RecipeFood.create(quantity: 10, food_id: @food.id, recipe_id: @recipe.id)

    visit new_user_session_path
    fill_in 'Email', with: @user.email
    fill_in 'Password', with: @user.password
    click_button 'Log in'
  end

  describe 'recipe Food validation' do
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
