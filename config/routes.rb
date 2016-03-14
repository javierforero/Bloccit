Rails.application.routes.draw do

  resources :advertisements
  resources :posts

  get 'about' => 'welcome#about'

  root 'welcome#index'

  get 'welcome/faq'
end
