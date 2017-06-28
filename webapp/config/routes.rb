Rails.application.routes.draw do
  mount Monologue::Engine, at: '/blog'

  # Profile
  get 'profile/post/new', to: 'profile#new_house'
  get 'profile/post/:link', to: 'profile#edit_house'
  get 'profile/post/:link/photo', to: 'profile#edit_photo'
  post 'profile/post/new', to: 'profile#post_house'
  post 'profile/post/:id', to: 'profile#put_house'
  post 'profile/post/:id/photo', to: 'profile#put_photo'
  delete 'profile/post/:id', to: 'profile#delete_house'
  get 'profile/posts', to: 'profile#list_house'
  get 'profile/edit', to: 'profile#edit_profile'
  post 'profile/edit', to: 'profile#put_profile'
  get 'profile/budget', to: 'profile#show_budget'

  # Admin
  get 'profile/users', to: 'admin#list_user'
  post 'profile/user/:id/role', to: 'admin#edit_role'
  get 'profile/user/:id', to: 'admin#edit_user'
  post 'profile/user/:id/edit', to: 'admin#put_user'
  post 'profile/user/:id/is_home', to: 'admin#is_home_user'
  post 'profile/post/:id/status', to: 'admin#status_post'
  post 'profile/post/:id/is_home', to: 'admin#is_home_post'
  get 'profile/projects', to: 'admin#list_project'
  get 'profile/project/new', to: 'admin#new_project'
  get 'profile/project/:id', to: 'admin#edit_project'
  get 'profile/project/:id/photo', to: 'admin#edit_project_photo'
  post 'profile/project/:id/edit', to: 'admin#put_project'
  post 'profile/project/:id/photo', to: 'admin#put_project_photo'
  delete 'profile/project/:id', to: 'admin#delete_project'
  post 'profile/project', to: 'admin#post_project'
  post 'profile/project/:id/is_home', to: 'admin#is_home_project'
  get 'profile/budget/callback', to: 'admin#callback_budget'

  # Photo
  get 'photo/:user_id/:name', to: 'photo#load_avatar'
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
