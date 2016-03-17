Rails.application.routes.draw do

  resources :posts, :advertisements, :questions, :topics

  get 'about' => 'welcome#about'

  root 'welcome#index'

  get 'welcome/faq'
end
