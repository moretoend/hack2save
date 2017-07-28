require "sidekiq/web"

Rails.application.routes.draw do
  devise_for :users, :controllers => { registrations: "registrations", :omniauth_callbacks => "callbacks" }
  mount Sidekiq::Web => 'sidekiq'

  root to: "home#index"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
