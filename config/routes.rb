Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
  get "/cards", to: "cards#index"
  get "/legacy", to: "legacy#index"
  resources :sheets, only: [:new, :create, :show]

  root "cards#show"
  post "/guess", to: "cards#guess", as: :guess
  post "/reset", to: "cards#reset", as: :reset
  post "/choose_deck", to: "cards#choose_deck", as: :choose_deck
  get "/cards/edit", to: "cards#edit"
  resources :cards
end
