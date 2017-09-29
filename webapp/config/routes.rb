Rails.application.routes.draw do

  scope 'profile/' do

    resources 'house' do
      collection do
        get ':link/photo', to: 'house#edit_photo'
        post ':id/photo', to: 'house#create_photo'

        post ':id/status', to: 'house#status_post'
        post ':id/is_home', to: 'house#is_home_post'
      end
    end

    resources 'post' do
    end

  end

  resources 'profile', except: [:show] do
    collection do
      get 'edit', to: 'profile#edit_profile'
      post 'edit', to: 'profile#put_profile'
      get 'budget', to: 'profile#show_budget'
      get 'bookmarks', to: 'profile#list_bookmark'
      put 'bookmark', to: 'profile#toggle_bookmark'
      delete 'bookmark/:id', to: 'profile#delete_bookmark'
    end
  end

  # Admin
  resources 'profile', except: [:show] do
    collection do
      get 'users', to: 'admin#list_user'
      post 'user/:id/role', to: 'admin#edit_role'
      get 'user/:id', to: 'admin#edit_user'
      post 'user/:id/edit', to: 'admin#put_user'
      post 'user/:id/is_home', to: 'admin#is_home_user'
      get 'projects', to: 'admin#list_project'
      get 'project/new', to: 'admin#new_project'
      get 'project/:id', to: 'admin#edit_project'
      get 'project/:id/photo', to: 'admin#edit_project_photo'
      post 'project/:id/edit', to: 'admin#put_project'
      post 'project/:id/photo', to: 'admin#put_project_photo'
      delete 'project/:id', to: 'admin#delete_project'
      post 'project', to: 'admin#post_project'
      post 'project/:id/is_home', to: 'admin#is_home_project'
      post 'budget/callback', to: 'admin#callback_budget'
      get 'services', to: 'admin#list_services'
      get 'service/:id', to: 'admin#edit_service'
      post 'service/:id/edit', to: 'admin#put_service'
    end
  end

  # Photo
  get 'photo/:user_id/:name', to: 'photo#load_avatar'
  get 'photo/:user_id/:house_id/:name', to: 'photo#load_photo'
  delete 'photo/:id', to: 'photo#delete_photo'

  # Home
  root 'home#index'

  get 'search', to: 'home#search'
  get 'detail/:id', to: 'home#detail'
  get 'contact', to: 'home#contact'

  # posts, agents, blogs, projects

  # Devise
  devise_for :users, :controllers => {
      :omniauth_callbacks => 'authentication/omniauth_callbacks',
      :registrations => 'devise/registrations_custom',
      :confirmations => 'devise/confirmations_custom',
      :sessions => 'devise/sessions_custom'
  }

  # Github
  post 'api/webhook/github', to: 'admin#webhook_github'

end
