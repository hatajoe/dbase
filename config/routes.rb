Rails.application.routes.draw do
  root 'dashboard#index'
  resources :organizations

  namespace :session do
    resources :users, only: %i[index new destroy]
    resources :organizations, only: %i[create destroy]
  end
  scope module: :session do
    get 'auth/:provider/callback', to: 'users#create'
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
