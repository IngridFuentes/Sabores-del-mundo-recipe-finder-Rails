Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root "welcome#home"
  get "about", to: "welcome#about"
  # get "/login", to: redirect("/auth/google_oauth2")
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  get "/auth/google_oauth2/callback", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"

  resource :session, only: [:create, :destroy]
  resources :users do
    resources :recipes
  end
  resources :recipes
  get "/signup", to: "users#new"
  resources :users, except: [:new]
end
