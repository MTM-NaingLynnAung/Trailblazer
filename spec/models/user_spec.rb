require 'rails_helper'

RSpec.describe User, type: :model do
  user = User.new(
    name: 'rspec test',
    email: 'rspec@test.com',
    password: 'password',
    password_confirmation: 'password',
    user_type: 'user'
  )
  context 'validation tests' do 
    it 'creating user with correct info' do
      expect(user).to be_valid
    end

    it 'name is blank' do 
      user.name = nil
      expect(user).not_to be_valid
    end

    it 'email is blank' do 
      user.email = nil
      expect(user).not_to be_valid
    end

    it 'password is blank' do 
      user.password = nil
      expect(user).not_to be_valid
    end

    it 'password confirmation is blank' do 
      user.password_confirmation = nil
      expect(user).not_to be_valid
    end

    it 'user_type is blank' do 
      user.user_type = nil
      expect(user).not_to be_valid
    end
  end
end
