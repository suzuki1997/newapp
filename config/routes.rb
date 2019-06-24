Rails.application.routes.draw do

  root "top#index"
  get "/contact",to:"top#contact"
  get '/signup',to:"users#new"
  resources :users
end
