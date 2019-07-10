Rails.application.routes.draw do

  root "top#index"
  get "/contact",to:"top#contact"
  get '/signup',to:"users#new"
  get "/login",to:"sessions#new"
  post "/login",to:"sessions#create"
  delete "/logout",to:"sessions#destroy"
  resources :users do
    member do
      get :following,:followers
    end
  end
  resources :posts,only:[:create,:destroy]
  resources :relationships,only:[:create,:destroy]
  
  get "posts/index",to:"posts#index"
end
