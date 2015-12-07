Rails.application.routes.draw do

  root 'pages#index'

  resources :junior_stories

  mount RailsAdmin::Engine => '/details', as: 'rails_admin'
end
