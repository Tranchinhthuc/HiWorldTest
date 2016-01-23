Rails.application.routes.draw do
  devise_for :users
  root 'registers#index'
  resources :users
  resources :registers
  resources :hashtags
  resources :comments do
    collection {get :search, to: "comments#index"}
  end
end
