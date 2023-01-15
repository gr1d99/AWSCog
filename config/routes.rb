Rails.application.routes.draw do
  post '/auth', to: 'auth#create'
end
