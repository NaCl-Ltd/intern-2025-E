Rails.application.routes.draw do
  get 'password_resets/new'
  get 'password_resets/edit'
  root   "static_pages#home"
  get    "/help",    to: "static_pages#help"
  get    "/about",   to: "static_pages#about"
  get    "/contact", to: "static_pages#contact"
  get    "/signup",  to: "users#new"
  get    "/login",   to: "sessions#new"
  post   "/login",   to: "sessions#create"
  delete "/logout",  to: "sessions#destroy"
  get  '/locale/:locale', to: 'locales#change', as: :change_locale
  resources :users do
    member do
      get :following, :followers
    end
  end
  resources :account_activations, only: [:edit]
  resources :password_resets,     only: [:new, :create, :edit, :update]
  resources :microposts,          only: [:create, :destroy]do
    collection do
      get :latest
    end
  end
  resources :relationships,       only: [:create, :destroy]
  get '/microposts', to: 'static_pages#home'
  resources :microposts, only: [:create, :destroy] do 
    member do
      patch :pin       # POST /microposts/1/pin
      patch :unpin     # POST /microposts/1/unpin
    end
  end
end
