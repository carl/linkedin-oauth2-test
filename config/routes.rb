LinkedinOauth2Test::Application.routes.draw do
  get '/auth/:linkedin_oauth2/callback', to: 'sessions#create'
  get '/sessions/new', to: 'sessions#new'
end
