Rails.application.routes.draw do
  root 'dashboard#index'
  resources :organizations
  resources :products, only: %i(index show new create update destroy)
  resources :repositories, only: %i(index)

  namespace :session do
    resources :users, only: %i(index new destroy)
    resources :organizations, only: %i(create destroy)
  end
  scope module: :session do
    get 'auth/:provider/callback', to: 'users#create'
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
