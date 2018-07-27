Rails.application.routes.draw do
  post 'authentication/login', to: 'authentication#authenticate'
end
