SampleApp::Application.routes.draw do
  get "static_pages/home"

  get "static_pages/help"

  root to: 'users#index'
  resources :users do
    resources :microposts
  end

end
