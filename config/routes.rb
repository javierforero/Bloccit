Rails.application.routes.draw do

  resources :advertisements
  resources :questions

  resources :topics do
    resources :posts, except: [:index]
  end

  resources :users, only: [:new, :create]
  resources :sessions, only: [:new, :create, :destroy]

  get 'about' => 'welcome#about'

  post 'users/confirm' => 'users#confirm'

  root 'welcome#index'

  get 'welcome/faq'
end
