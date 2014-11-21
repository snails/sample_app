SampleApp::Application.routes.draw do
  get "static_pages/home"
  get "static_pages/help"
  get "static_pages/about"

  root to: 'users#index'
  resources :users do
    resources :microposts
  end

end
