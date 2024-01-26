require 'rails_helper'

RSpec.describe Food, type: :model do
  describe 'validations' do
    it 'is valid with valid attributes' do
      user = User.create(email: 'noel@example.com', password: 'password')
      food = Food.new(
        name: 'rice',
        measurment_unit: 'grams',
        price: 20,
        quantity: 10,
        user:
      )

      expect(food).to be_valid
    end

    it 'is not valid without a name' do
      food = Food.new(name: nil)
      expect(food).to_not be_valid
    end

    it 'is not valid without a measurment unit' do
      food = Food.new(measurment_unit: nil)
      expect(food).to_not be_valid
    end

    it 'is not valid without a price' do
      food = Food.new(price: nil)
      expect(food).to_not be_valid
    end

    it 'is not valid with a non-positive price' do
      food = Food.new(price: -1)
      expect(food).to_not be_valid
    end

    it 'is not valid without a quantity' do
      food = Food.new(quantity: nil)
      expect(food).to_not be_valid
    end

    it 'is not valid with a negative quantity' do
      food = Food.new(quantity: -1)
      expect(food).to_not be_valid
      end
    end
end