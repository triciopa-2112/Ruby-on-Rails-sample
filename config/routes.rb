Rails.application.routes.draw do
  get 'users/new'

  get 'static_pages/home'
  get 'about' => 'static_pages#about'
  get 'help' => 'static_pages#help'
  get 'contact' => 'static_pages#contact'
  get 'signup' => 'users#new'
  resources :users
  
  root 'static_pages#home'

  
end
