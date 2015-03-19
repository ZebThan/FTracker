Rails.application.routes.draw do
  resources :matches

  resources :players

  root 'home#index'
  
end