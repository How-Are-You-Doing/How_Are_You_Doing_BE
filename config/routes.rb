Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  namespace :api do 
    namespace :v1 do 
      resources :emotions, only: [:index]

      resource :users, only: [:new, :create] do
        resources :posts, only: [:index], path: :history
      end
    end
  end
end
