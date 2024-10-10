Rails.application.routes.draw do
  get 'home/index'
  root 'home#index'
  resources :expenses do
    member do
      get 'approved'
    end
    collection do
      get :status
      get 'monthly_status/:year', to: 'expenses#monthly_status', as: 'monthly_status'
    end
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.

  # Defines the root path route ("/")
  # root "posts#index"
end
