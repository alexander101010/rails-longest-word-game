Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get 'new', to: 'games#new'
  get 'score', to: 'games#score'
  post 'score', to: 'games#score'
end


# Prefix Verb URI Pattern      Controller#Action
#    new GET  /new(.:format)   games#new
#  score POST /score(.:format) games#score

#  root to: 'pages#home'
#   get 'about', to: 'pages#about'
#   get 'contact', to: 'pages#contact'
