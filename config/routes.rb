Rails.application.routes.draw do
  devise_for :users
  root to: "home#index"

  scope module: :user do
    resources :products, only: %i[index show]
  end
end
