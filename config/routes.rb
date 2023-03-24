Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "events#index"
  get 'signup', to: 'users#new'
  post 'login', to: 'users#login'
  delete 'logout', to: 'users#logout'
  resources :users , except: [:new]
  resources :events do
    resources :comments, except: [:index]
  end
  resources :statuses
end
