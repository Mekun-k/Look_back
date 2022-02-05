Rails.application.routes.draw do
  resources :tasks do
    collection do
      get 'today'
    end
  end
  devise_for :users, controllers: {
    omniauth_callbacks: "omniauth_callbacks"
}
  root 'pages#index'
  get 'pages/show'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
