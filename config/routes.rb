require 'sidekiq/web'

Rails.application.routes.draw do
  mount Sidekiq::Web => '/sidekiq'
  mount_devise_token_auth_for 'User', at: 'auth'
  #devise_for :users,
             #controllers: {
               #sessions: 'sessions',
               #registrations: 'registrations'
             #},
             #skip: [:passwords]

  namespace :v1 do#, contraints: ApiConstraint.new(version: 1) do
    jsonapi_resources :users, only: [:index, :show, :create]
    jsonapi_resources :posts
    jsonapi_resources :albums
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # Serve websocket cable requests in-process
  # mount ActionCable.server => '/cable'
end
