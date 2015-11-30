Rails.application.routes.draw do

  root 'pages#index'

  resources :junior_stories
end
