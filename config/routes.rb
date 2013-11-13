LinkedinOauth2Test::Application.routes.draw do
  get '/auth/:linkedin/callback', to: 'sessions#create'
  get '/sessions/new', to: 'sessions#new'
end
