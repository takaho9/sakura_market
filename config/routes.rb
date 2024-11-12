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
  root to: "users/products#index"

  namespace :admins do
    resources :products
    resources :users, except: %i[new create]
    resources :orders, only: %i[index show edit update]
    patch "update_display_order_products", to: "site_settings#update_display_order_products", as: "update_products_order"
  end

  scope module: :users do
    resources :products, only: %i[index show]
    resources :cart_items, only: %i[index create destroy] do
      member do
        patch :increment
        patch :decrement
      end
    end
    resource :user, only: %i[show] do
      member do
        get :edit_address
        patch :update_address
      end
    end
    resources :orders do
      member do
        get :confirm
      end
    end
  end
end
