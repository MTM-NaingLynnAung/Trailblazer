require 'rails_helper'

RSpec.describe "Users", type: :request do

  before do
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(current_user)
  end
  # User Login
  context "POST /posts" do
    it 'invalid credentials' do
      post "/login", params: {
        user: {
          email: 'rspec@test.com',
          password: 'a'
        }
      }
      expect(subject).to render_template(:login)
    end

    it 'valid credentials' do
      post "/login", params: {
        user: {
          email: 'admin@gmail.com',
          password: 'password'
        }
      }
      expect(subject).to redirect_to(posts_path)
    end
  end

  # User List
  context "GET /users" do
    it 'User List'do
      get "/users"
      expect(response).to render_template(:index)
    end
  end

  # User Create
  context "POST /users/new" do
    it 'User Create to success' do
      post "/users", params: { 
                                user: {
                                  name: 'rspec',
                                  email: 'rspec@gmail.com',
                                  password: 'password',
                                  password_confirmation: 'password',
                                  phone: '09213456543',
                                  address: 'address test',
                                  dob: "2022-10-31",
                                  user_type: 'User'
                                }
                              }
      expect(flash[:notice]).to eq('User created successfully')
    end

    it 'User Create to fail' do
      post "/users", params: {
                                user: {
                                  name: 'rspec',
                                  email: 'rspec@gmail.com',
                                  password: 'password',
                                  password_confirmation: 'pass',
                                  user_type: 'User'
                                }
                              }
      expect(response).to render_template(:new)
      expect(response).to have_http_status(422)
    end

  end

  # User Show Details
  context "GET /users/:id" do
    it 'User Show Details' do
      user = User.last
      get "/users/#{user.id}"
      expect(response).to have_http_status(200)
      expect(response).to render_template(:show)
    end
  end

  # User Update
  context "PATCH /users/:id/edit" do
    it 'User Update to success' do
      user = User.last
      patch "/users/#{user.id}", params: { user: 
                                            {
                                              name: 'update',
                                              email: 'test@gmail.com',
                                              phone: '09124356756',
                                              address: 'address test update',
                                              dob: "2022-10-21",
                                              user_type: 'Admin'
                                            }
                                          }
      expect(flash[:notice]).to eq('User updated successfully')
    end

    it 'User Update to fail' do
      user = User.last
      patch "/users/#{user.id}", params: { user: 
                                            {
                                              name: '',
                                              email: 'test@gmail.com',
                                              phone: '09124356756',
                                              address: 'address test update',
                                              dob: "2022-10-21",
                                              user_type: 'Admin'
                                            }
                                          }
      expect(response).to render_template(:edit)
      expect(response).to have_http_status(422)
    end

  end

  # Delete User
  context 'Delete users/:id' do
    it 'User Delete' do
      user = User.last
      delete "/users/#{user.id}"
      expect(flash[:notice]).to eq('User deleted successfully')
    end
  end

end
