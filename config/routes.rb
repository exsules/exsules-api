require 'sidekiq/web'

Rails.application.routes.draw do
  mount Sidekiq::Web => '/sidekiq'
  mount_devise_token_auth_for 'User', at: 'auth'

  namespace :v1 do#, contraints: ApiConstraint.new(version: 1) do
    resources :users, only: [:index, :show, :create] do
      member do
        get 'posts' => 'posts#show_relationship'
      end
    end
    resources :posts
    resources :albums

    get 'searches' => 'searches#index'
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # Serve websocket cable requests in-process
  # mount ActionCable.server => '/cable'
end
