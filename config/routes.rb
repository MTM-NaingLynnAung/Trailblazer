Rails.application.routes.draw do
  get 'login/login'
  get 'users/index'
  get 'users/new'
  get 'users/show'
  get 'users/edit'
  get 'posts/index'
  get 'posts/new'
  get 'posts/show'
  get 'posts/edit'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
