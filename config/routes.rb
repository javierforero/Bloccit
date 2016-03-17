Rails.application.routes.draw do

  resources :posts, :advertisements, :questions

  get 'about' => 'welcome#about'

  root 'welcome#index'

  get 'welcome/faq'
end
