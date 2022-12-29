Rails.application.routes.draw do
  #resources :posts
  #root "articles#index"
  resources :topics do
    resources :posts do
      resources :comments, only: [:index, :new, :create]
      resources :tags
    end
  end
  resources :tags
  resources :posts do
    resources :comments, only: [:show,:new, :edit, :update, :destroy]
  end
  #shallow: true means only: [:index, :new, :create]
  resources :insides
  resources :articles do
    resources :insides
  end
  resources :books
  resources :high_scores
  get 'greetings/hello'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
