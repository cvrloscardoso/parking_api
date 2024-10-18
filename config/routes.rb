Rails.application.routes.draw do
  get 'up' => 'rails/health#show', as: :rails_health_check

  resources :parking, only: %i[create show] do
    member do
      put '/out' => :out
      put '/pay' => :pay
    end
  end
end
