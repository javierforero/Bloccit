Rails.application.routes.draw do

  resources :posts, :advertisements, :topics, :questions

  get 'about' => 'welcome#about'

  root 'welcome#index'

  get 'welcome/faq'
end
