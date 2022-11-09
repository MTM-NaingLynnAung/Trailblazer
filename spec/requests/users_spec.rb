require 'rails_helper'

RSpec.describe "Users", type: :request do
  
  before { allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(current_user) }
  
  # User Login
  describe "POST /posts" do
    scenario 'invalid credentials' do
      post "/login", params: {
        user: {
          email: 'rspec@test.com',
          password: 'a'
        }
      }
      expect(subject).to render_template(:login)
    end

    scenario 'valid credentials' do
      post "/login", params: {
        user: { 
          email: 'test@gmail.com', 
          password: 'a',
        } 
      }
      expect(subject).to redirect_to(posts_path)
    end
  end

  # User List
  describe "GET /users" do
    scenario 'User List'do
      get "/users"
      expect(response).to render_template(:index)
    end
  end

  # User Create
  describe "POST /users" do
    scenario 'User Create' do
      post "/users", params: { user:  
                                {
                                  name: 'rspec',
                                  email: 'rspec@gmail.com',
                                  password: 'password',
                                  password_confirmation: 'password',
                                  phone: '09213456543',
                                  address: 'address test',
                                  dob: "2022-10-31",
                                  user_type: 'Admin'
                                }
                              }
      expect(flash[:notice]).to eq('User created successfully')
    end
  end

  # User Show Details
  describe "GET /users/:id" do
    scenario 'User Show Details' do
      user = User.last
      get "/users/#{user.id}"
      expect(response).to have_http_status(200)
      expect(response).to render_template(:show)
    end
  end

  #User Update
  describe "PUT /users/:id/edit" do
    scenario 'User Update' do
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
  end

  # Delete User
  describe 'Delete users/:id' do
    scenario 'User Delete' do
      user = User.last
      delete "/users/#{user.id}"
      expect(flash[:notice]).to eq('User deleted successfully')
    end
  end

end
