SampleApp::Application.routes.draw do
  root to: 'static_pages#home'
  match '/help', to: "static_pages#help"
  match '/about', to: "static_pages#about"
  match '/contact', to: "static_pages#contact"

  resources :users do
    member do
      get :following, :followers
    end
  end
  resources :microposts, only: [:create, :destroy]
  resources :sessions, only: [:new, :create, :destroy]
  resources :relationships, only: [:create, :destroy]
  
  match '/signup', to: "users#new"
  match '/signin', to: "sessions#new"
  match '/signout', to: "sessions#destroy", via: :delete

  match '/passwordinfo', to: "users#passwordinfo", via: :get
  match '/password_forget', to:"users#password_forget", via: :post
  match '/edit_password', to:"users#edit_password", via: :get
  match '/reset_password', to: "users#reset_password", via: :put

end
