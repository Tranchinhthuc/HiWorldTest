Rails.application.routes.draw do
  root 'registers#index'
  devise_for :users, :controllers => { :omniauth_callbacks => "callbacks" }
  resources :users
  resources :registers
  resources :hashtags
  resources :comments do
    collection {get :search, to: "comments#index"}
  end
end
