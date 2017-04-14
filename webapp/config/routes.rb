Rails.application.routes.draw do

  root 'home#index'

  get 'search', to: 'home#search'

end
