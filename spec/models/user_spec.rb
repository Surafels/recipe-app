require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = User.new(name: 'Test User', email: 'test@example.com', password: 'password',
                     password_confirmation: 'password')
  end

  it 'is valid with valid attributes' do
    expect(@user).to be_valid
  end

  it 'is not valid without a name' do
    @user.name = nil
    expect(@user).to_not be_valid
  end

  it 'is not valid without an email' do
    @user.email = nil
    expect(@user).to_not be_valid
  end

  it 'is not valid without a password' do
    @user.password = nil
    expect(@user).to_not be_valid
  end
end
