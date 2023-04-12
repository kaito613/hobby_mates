Rails.application.routes.draw do

  root "top#home"

  devise_for :users
  resources :users, only: %i[show]
  
  resources :boards, only: %i[index]
  resources :comments, only: %i[index]
end
