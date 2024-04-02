Rails.application.routes.draw do
  root to: redirect('/photos')
  get    "/login",   to: "sessions#new"
  post   "/login",   to: "sessions#create"
  delete "/logout",  to: "sessions#destroy"

  resources :photos, only: [:index, :new, :create]

  # OAuth認可のコールバック用
  get "/oauth/callback", to: "oauth_sessions#receive_oauth_response"

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check
end
