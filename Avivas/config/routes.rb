Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions',registrations: 'users/registrations'
  }

  resources :users, only: [:index] do
    member do
      get :edit_administracion     
      patch :update_administracion 
      delete :desactivar, to: 'users#desactivar'  
    end
  end

  resources :productos do
    member do
      get 'edit_stock'  
      patch 'update_stock'  
    end
  end

  resources :ventas do
    member do
      patch :cancel
    end
  end
  
  

  get "home/index"

  get "up" => "rails/health#show", as: :rails_health_check

  root 'home#index'  # Esto establece el controlador y acción para la página de inicio
  get 'home/por_categoria', to: 'home#index', as: :home_por_categoria

  get '/favicon.ico', to: redirect('/assets/favicon.ico', status: 200)



end
