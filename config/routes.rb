Rails.application.routes.draw do
  root "static#show", page: "home"

  namespace :api do
    namespace :v1 do
      resources :photos, only: [:index], :defaults => {:format => 'json'}
      resources :challenges, only: [:index], :defaults => {:format => 'json'}
      resources :leaderboards, only: [:index, :create], :defaults => {:format => 'json'}
    end
  end
end
