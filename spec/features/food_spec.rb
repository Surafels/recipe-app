RSpec.describe 'Food', type: :feature do
    before(:each) do
      @user = User.create(name: 'new', email: 'user@gmail.com', password: '123456',
                          password_confirmation: '123456')
      @recipe = Recipe.create(name: 'Pizza', preparation_time: 2, cooking_time: 3, description: 'best pizza',
                              public: true, user_id: @user.id)
      @food = Food.create(name: 'Apple', measurment_unit: 'Kg', price: 10, quantity: 20, user_id: @user.id)
      @recipe_food = RecipeFood.create(quantity: 10, food_id: @food.id, recipe_id: @recipe.id)
  
      visit new_user_session_path
      fill_in 'Email', with: @user.email
      fill_in 'Password', with: @user.password
      click_button 'Log in'
    end
  
    describe 'Test for food page' do
      it 'creates a new food' do
        visit new_food_path
        fill_in 'Name', with: 'Orange'
        fill_in 'Measurment unit', with: 'grams'
        fill_in 'Price', with: 11
        fill_in 'Quantity', with: 10
        click_button 'Save'
        expect(page).to have_content('Orange')
      end
  
      it 'displays the created food on the index page' do
        visit foods_path
        expect(page).to have_content('Apple')
        expect(page).to have_content('Kg')
        expect(page).to have_content(10)
        expect(page).to have_content('Delete')
      end
  
      it 'has a delete button' do
        visit foods_path
        expect(page).to have_content('Delete')
      end
    end
  end