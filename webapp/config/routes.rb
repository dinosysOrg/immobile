Rails.application.routes.draw do

  get 'editor/new', to: 'editor#new'
  post 'editor/new', to: 'editor#newProduct'
  get 'editor/list', to: 'editor#list'

  root 'home#index'

  get 'search', to: 'home#search'
  get 'detail/:id', to: 'home#detail'
  get 'contact', to: 'home#contact'

  devise_for :users, :controllers => {
      :omniauth_callbacks => 'authentication/omniauth_callbacks',
      :registrations => 'devise/registrations_custom',
      :confirmations => 'devise/confirmations_custom',
      :sessions => 'devise/sessions_custom'
  }

end
