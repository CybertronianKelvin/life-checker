Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root 'patients#new'
  post 'patients/validate', to: 'patients#validate'
  get 'questions', to: 'questions#index'
  post 'questions/submit', to: 'questions#submit'
end
