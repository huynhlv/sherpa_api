Rails.application.routes.draw do
  devise_for :users, only: []
  namespace :api do
    resources :users, only: %i(show create update destroy)
    resources :sessions, only: %i(create destroy)
    resources :advertiser_accounts
  end
end
