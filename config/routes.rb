Rails.application.routes.draw do
  root to: 'home#index'
  get '/auth/reddit', as: :reddit_login
  get '/auth/reddit/callback', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
end
