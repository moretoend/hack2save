require "sidekiq/web"

Rails.application.routes.draw do
  devise_for :users
  mount Sidekiq::Web => 'sidekiq'

  root to: "home#index"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
