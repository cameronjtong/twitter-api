Rails.application.routes.draw do
  post "/login", to: "sessions#create"
  post "/logout", to: "sessions#destroy"
  resources :users
  resources :conversations do
    resources :messages
  end
end
