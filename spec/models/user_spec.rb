require 'rails_helper'

RSpec.describe User, type: :model do
  subject {
    User.new(
      name: 'rspec test',
      email: 'test@test.com',
      password: 'password',
      password_confirmation: 'password',
      user_type: 'Admin'
    )
  }
  
  context 'validation tests' do 
    it 'creating user with correct info' do
      expect(subject).to be_valid
    end

    it 'is not valid, if name is blank' do 
      subject.name = nil
      expect(subject).not_to be_valid
    end

    it 'is not valid, if name is too long' do
      subject.name = 'a' * 101
      expect(subject).not_to be_valid
    end

    it 'is not valid, if email is blank' do 
      subject.email = nil
      expect(subject).not_to be_valid
    end

    it 'is not valid, if email format is wrong' do 
      subject.email = 'email'
      expect(subject).not_to be_valid
    end

    it 'is not valid, if password is blank' do 
      subject.password = nil
      expect(subject).not_to be_valid
    end

    it 'is not valid, if password and password confirmation doesnt match' do
      subject.password = 'password'
      subject.password_confirmation = 'pass'
      expect(subject).not_to be_valid
    end

    it 'is not valid, if password confirmation is blank' do 
      subject.password_confirmation = nil
      expect(subject).not_to be_valid
    end

    it 'is not valid, if phone is not number' do
      subject.phone = 'abc'
      expect(subject).not_to be_valid
    end

    it 'is not valid, if phone is too long' do
      subject.phone = '091234567899999'
      expect(subject).not_to be_valid
    end

    it 'is not valid, if address is too long' do
      subject.address = 'a' * 256
      expect(subject).not_to be_valid
    end

  end
end
