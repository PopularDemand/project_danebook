Rails.application.routes.draw do
  delete 'logout' => 'sessions#destroy'
  post 'login' => 'sessions#create'

  root "users#new"
  resources :users do
    resource :profile, except: [:new, :create, :destroy]
    get 'timeline', to: 'posts#timeline'
  end
end
