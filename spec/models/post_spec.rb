require 'rails_helper'

RSpec.describe Post, type: :model do
  user = User.create!(
    name: 'test user',
    email: 'test@gmail.com',
    password: 'a',
    password_confirmation: 'a',
    user_type: 'Admin'
  )
  subject { 
    Post.new(
      title: 'rspec title',
      description: 'rspec description',
      privacy: 1,
      user_id: user.id
    )
  }
  context 'validation tests' do
    it 'create post with valid info' do
      expect(subject).to be_valid
    end

    it 'is not valid, if title is blank' do
      subject.title = nil
      expect(subject).not_to be_valid
    end

    it 'is not valid, if title is too long' do
      subject.title = 'a' * 31
      expect(subject).not_to be_valid
    end

    it 'is not valid, if description is blank' do
      subject.description = nil
      expect(subject).not_to be_valid
    end

    it 'is not valid, if privacy is blank' do
      subject.privacy = nil
      expect(subject).not_to be_valid
    end

    it 'is not valid, if user doesnt exist' do
      subject.user_id = nil
      expect(subject).not_to be_valid
    end

  end
end
