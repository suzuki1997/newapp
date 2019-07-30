Rails.application.routes.draw do

  root "top#index"
  get "/contact",to:"top#contact"
  
  controller :users do
    resources :users
    resources :users do
      member do
        get :following,:followers
      end
    end
    get "users/:id/likes",to:"users#likes"
    get '/signup',to:"users#new"
  end
  
  controller :sessions do
    get "/login",to:"sessions#new"
    post "/login",to:"sessions#create"
    delete "/logout",to:"sessions#destroy"
  end

  controller :posts do
    resources :posts,only:[:create,:destroy]
    get "/posts/:id",to:"posts#show"
    get "posts/index",to:"posts#index"
  end
  
  controller :likes do
    post "likes/:post_id/create",to: "likes#create"
    post "likes/:post_id/destroy",to: "likes#destroy"
  end
  
  resources :relationships,only:[:create,:destroy]
  
  
end
