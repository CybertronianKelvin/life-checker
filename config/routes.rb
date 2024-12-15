Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root 'patients#new'
  post 'patients/validate', to: 'patients#validate'
  get 'questions', to: 'questions#index'
  post 'questions/submit', to: 'questions#submit'

  namespace :admin do
    resources :scoring_rules, only: %i[index edit update]
  end
end
