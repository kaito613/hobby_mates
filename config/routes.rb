Rails.application.routes.draw do

  root "top#home"

  devise_for :users
  resources :users, only: %i[ show ]
  
  resources :boards, only: %i[ new create show edit update destroy] do
    resources :comments, only: %i[ create edit show update destroy ], shallow: true
  end
end
