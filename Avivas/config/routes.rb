Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations' , 
    sessions: 'users/sessions'
  }

  resources :users do
    member do
      get :desactivar  
    end
  end
  get "home/index"

  get "up" => "rails/health#show", as: :rails_health_check

  root 'home#index'  # Esto establece el controlador y acción para la página de inicio
  get '/favicon.ico', to: redirect('/assets/favicon.ico', status: 200)



end
