Rails.application.routes.draw do
  scope "(:locale)", locale: /en|vi/ do
    root "static_pages#home"
    get "/help", to:"static_pages#help"
    get "/about", to:"static_pages#about"
    get "/contact", to:"static_pages#contact"
    get "/signup", to: "users#new"
    post "/signup", to: "users#create"
    get "/login", to: "sessions#new"
    get "/logout", to: "sessions#destroy"
    post "/login", to: "sessions#create"
    resources :users
    resources :account_activations, only: :edit
    resources :password_resets, only: %i(new create edit update)
  end
end
