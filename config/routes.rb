Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'businesses#index'
  #get 'ui(/:action)', controller: 'ui'
  get '/sign_in', to: "sessions#new"
  get '/sign_out', to: "sessions#destroy"
  get '/recent_reviews', to: "reviews#index"
  
  resources :businesses, except: [:destroy, :edit] do 
    resources :reviews, only: [:create, :index]
  end
  resources :users, only: [:create, :show, :new]
  resources :sessions, only: [:create]
end
