require 'sidekiq/web'

Rails.application.routes.draw do
  mount Sidekiq::Web => '/sidekiq'
  mount_devise_token_auth_for 'User', at: 'auth'

  namespace :v1 do
    jsonapi_resources :users, only: [:index, :show]
    jsonapi_resources :posts
    jsonapi_resources :albums
    get 'searches' => 'searches#index'
  end
end
