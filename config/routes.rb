Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "events#index"
  get 'signup', to: 'users#new'
  post 'login', to: 'users#login'
  delete 'logout', to: 'users#logout'
  resources :statuses
  resources :users , except: [:new] do
    get "account_settings", to: "users#account_settings"
  end

  resources :events do
    resources :comments, except: [:index]
  end

end
