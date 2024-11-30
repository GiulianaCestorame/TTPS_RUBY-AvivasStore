Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions',registrations: 'users/registrations'
  }

  resources :users, only: [:index]
  delete '/users/:id/desactivar', to: 'users#desactivar', as: :desactivar_user


  get "home/index"

  get "up" => "rails/health#show", as: :rails_health_check

  root 'home#index'  # Esto establece el controlador y acción para la página de inicio
  get '/favicon.ico', to: redirect('/assets/favicon.ico', status: 200)



end
