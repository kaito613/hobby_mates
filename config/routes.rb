Rails.application.routes.draw do

  root "top#home"

  devise_for :users
  resources :users, only: %i[ show ]
  
  resources :boards do
    resources :comments, only: %i[ create edit show update destroy ], shallow: true
  end
end
