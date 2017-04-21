Rails.application.routes.draw do
  get 'editor/new', to: 'editor#new'
  get 'editor/list', to: 'editor#list'

  root 'home#index'

  get 'search', to: 'home#search'
  get 'detail', to: 'home#detail'
  get 'contact', to: 'home#contact'

end
