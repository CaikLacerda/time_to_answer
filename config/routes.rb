Rails.application.routes.draw do
  namespace :site do
    get "welcome/index"
    get "search", to: "search#questions"
    get 'subject', to: 'search#subject', as: 'search_subject'
    post "answer", to: "answer#question"
  end

  namespace :users_backoffice do
    get "welcome/index"
    get 'profile', to: 'profile#edit'
    patch 'profile', to: 'profile#update'
  end

  namespace :admins_backoffice do
    get "welcome/index"
    get "search", to: "search#questions"
    resources :admins
    resources :subjects
    resources :questions
  end
  
  devise_for :admins, skip: [:registrations]
  devise_for :users

  get 'inicio', to: "site/welcome#index"
  get 'backoffice', to: "admins_backoffice/welcome#index"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/*
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  # Defines the root path route ("/")
  # root "posts#index"[]
  root "site/welcome#index"
end
