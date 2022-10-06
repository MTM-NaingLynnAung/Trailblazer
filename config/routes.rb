Rails.application.routes.draw do
  root 'login#login'
  post '/login', to: 'login#action_login'
  delete '/logout', to: 'login#logout'
  resources :users do
    collection do 
      get :profile
      get :edit_profile
      put :edit_profile, to: 'users#update_profile'
      get :edit_password
      put :edit_password, to: 'users#update_password'
    end
  end
  resources :posts
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
