Rails.application.routes.draw do

  get 'editor/new', to: 'editor#new'
  get 'editor/list', to: 'editor#list'

  root 'home#index'

  get 'search', to: 'home#search'
  get 'detail/:id', to: 'home#detail'
  get 'contact', to: 'home#contact'

  devise_for :users, :controllers => {
      :omniauth_callbacks => 'devise/omniauth_callbacks',
      :registrations_custom => 'devise/registrations_custom',
      :sessions => 'devise/sessions_custom'
  }
end
