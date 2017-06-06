Rails.application.routes.draw do
  mount Monologue::Engine, at: '/blog'

  # Profile
  get 'profile/post/new', to: 'profile#new_house'
  get 'profile/post/:link', to: 'profile#edit_house'
  post 'profile/post/new', to: 'profile#post_house'
  post 'profile/post/:id', to: 'profile#put_house'
  delete 'profile/post/:id', to: 'profile#delete_house'
  get 'profile/posts', to: 'profile#list_house'
  get 'profile/edit', to: 'profile#edit_profile'
  post 'profile/edit', to: 'profile#put_profile'

  # Photo
  get 'photo/:user_id/:house_id/:name', to: 'photo#load_photo'
  delete 'photo/:id', to: 'photo#delete_photo'

  # Home
  root 'home#index'

  get 'search', to: 'home#search'
  get 'detail/:id', to: 'home#detail'
  get 'contact', to: 'home#contact'

  # Devise
  devise_for :users, :controllers => {
      :omniauth_callbacks => 'authentication/omniauth_callbacks',
      :registrations => 'devise/registrations_custom',
      :confirmations => 'devise/confirmations_custom',
      :sessions => 'devise/sessions_custom'
  }

end
