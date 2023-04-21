Rails.application.routes.draw do

  root "top#home"

  devise_for :users
  resources :users, only: %i[show]
  
  resources :boards
  resources :comments
end
