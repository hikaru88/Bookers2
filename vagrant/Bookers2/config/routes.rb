Rails.application.routes.draw do
  root to: 'users#top'
  get '/users/:id/home', to: 'books#home', as: 'user_home'

  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html


  resources :users, only: [:edit, :index, :show, :update, :destroy]

  resources :books, only: [:home, :index, :show, :edit, :update, :create, :destroy]

end
