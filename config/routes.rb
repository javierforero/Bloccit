Rails.application.routes.draw do

  resources :advertisements
  resources :questions

  resources :topics do
    resources :posts, except: [:index]
  end

  resources :users, only: [:new, :create]

  get 'about' => 'welcome#about'

  root 'welcome#index'

  get 'welcome/faq'
end
