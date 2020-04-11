Rails.application.routes.draw do
  post 'authenticate', to: 'authentications#authenticate'
  resources :items, only: [:index]
  resources :users, only: %i(new create)
  resources :trips, only: %i(index show create update destroy)
  resources :locations, only: %i(create)
end
