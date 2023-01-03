Rails.application.routes.draw do
  root "topics#index"
  devise_for :users, controllers: {
    #sessions: 'users/sessions',
    registrations: 'users/registrations'
  }
#resources :posts
  resources :topics do
    resources :posts do
      resources :comments
      resources :tags
      resources :ratings
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
