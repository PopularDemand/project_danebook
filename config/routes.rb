Rails.application.routes.draw do
  delete 'logout' => 'sessions#destroy'
  post 'login' => 'sessions#create'

  root "users#new"
  resources :users do
    resources :posts
    resource :profile, except: [:new, :create, :destroy]
    get 'timeline' => 'posts#timeline'
  end
end
