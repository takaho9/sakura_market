Rails.application.routes.draw do
  devise_for :admins, controllers: {
    registrations: "admins/registrations",
    sessions: "admins/sessions",
    passwords: "admins/passwords",
    confirmations: "admins/confirmations"
  }
  devise_for :users, controllers: {
    registrations: "users/registrations",
    sessions: "users/sessions",
    passwords: "users/passwords",
    confirmations: "users/confirmations"
  }
  root to: "home#index"

  namespace :admins do
    resources :products
  end

  scope module: :users do
    resources :products, only: %i[index show]
  end
end
