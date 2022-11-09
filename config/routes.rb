Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'welcome#index'
  namespace :api do
    namespace :v1 do
      resources :emotions, only: [:index]
      resources :users, only: [:create]
      resources :friends, only: [:index, :create, :update] do
        resources :posts, only: [:index], module: 'friends'
      end
      resources :posts, only: [:create]
      get 'posts/last', to: 'users/posts#most_recent'
      namespace :users do
        resources :posts, only: [:index], path: :history
      end
    end

    namespace :v2 do
      resource :users, only: [:show], action: :search
      resource :users, only: [:create] do
        resources :followers, only: [:index], module: :users
        resources :posts, only: [:index], path: :history, module: :users
      end
      
      resources :friends, only: [:index, :create, :update]
      resources :posts, only: [:create, :update, :destroy]
      resource :posts, only: [:show], path: 'posts/last'
      namespace :users do
        resources :posts, only: [:index], path: :history
        get "/posts", to: "posts#show"
      end
    end
  end
end
