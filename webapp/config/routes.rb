Rails.application.routes.draw do

  root 'home#index'

  get 'search', to: 'home#search'
  get 'detail', to: 'home#detail'
  get 'contact', to: 'home#contact'
  get 'edit', to: 'home#edit'

end
