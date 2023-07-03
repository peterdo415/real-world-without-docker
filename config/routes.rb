Rails.application.routes.draw do
  scope :api do
    post 'users/login', to: 'authentication#login'
    resources :users, only: %i[create]
    resources :articles, param: :slug, only: %i[show create update destroy]
  end
end
