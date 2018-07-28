Rails.application.routes.draw do
  post 'authentication/login', to: 'authentication#authenticate'
  post 'signup', to: 'users#create'

  resources :posts
end
