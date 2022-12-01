Rails.application.routes.draw do
  resources :topics
  resources :books
  resources :high_scores
  get 'greetings/hello'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
