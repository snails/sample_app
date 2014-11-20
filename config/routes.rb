SampleApp::Application.routes.draw do
  root to: 'users#index'
  resources :users do
    resources :microposts
  end

end
