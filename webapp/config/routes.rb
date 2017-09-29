Rails.application.routes.draw do

  # ************************** #
  # Profile
  # ************************** #
  scope 'profile/' do
    resources 'house' do
      collection do
        get ':link/photo', to: 'house#edit_photo'
        post ':id/photo', to: 'house#create_photo'
        post ':id/status', to: 'house#status_post'
        post ':id/is_home', to: 'house#is_home_post'
      end
    end

    resources 'project' do
      get ':id/photo', to: 'project#edit_photo'
      post ':id/photo', to: 'project#create_photo'
      post ':id/is_home', to: 'project#is_home'
    end

    resources 'user' do
      post ':id/role', to: 'user#edit_role_user'
      post ':id/is_home', to: 'user#is_home_user'
    end

    resources 'service' do
    end

    resources 'post' do
    end

    resources 'bookmark' do
    end

    resources 'budget' do
    end

  end

  resources 'profile', except: [:show] do
    collection do
      get 'edit', to: 'profile#edit'
    end
  end


  # ************************** #
  # Home
  # ************************** #
  root 'home#index'
  get 'search', to: 'home#search'
  get 'detail/:id', to: 'home#detail'
  get 'contact', to: 'home#contact'
  # posts, agents, blogs, projects


  # ************************** #
  # Admin
  # ************************** #
  resources 'admin' do
    collection do

    end
  end


  # ************************** #
  # Storage
  # ************************** #

  # Photo
  resources 'photo' do
    get ':user_id/:name', to: 'photo#load_avatar'
    get ':user_id/:house_id/:name', to: 'photo#load_photo'
  end


  # ************************** #
  # Devise
  # ************************** #
  devise_for :users, :controllers => {
      :omniauth_callbacks => 'authentication/omniauth_callbacks',
      :registrations => 'devise/registrations_custom',
      :confirmations => 'devise/confirmations_custom',
      :sessions => 'devise/sessions_custom'
  }


  # ************************** #
  # API
  # ************************** #

  # Github webhook
  post 'api/webhook/github', to: 'admin#webhook_github'
  post 'api/budget/callback', to: 'admin#callback_budget'

end
