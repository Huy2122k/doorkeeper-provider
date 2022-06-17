Rails.application.routes.draw do
  use_doorkeeper do
    controllers applications: 'oauth_applications'
  end
  devise_for :users
  devise_scope :user do
    get '/logout', to: 'devise/sessions#destroy'
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  resources :posts, only: [:index, :new, :create]
  resources :users, only: [:index, :show]
  namespace :api do
    namespace :v1 do
      resources :posts
      get '/me' => 'credentials#me'
    end
  end
  root to: 'pages#index'
end
