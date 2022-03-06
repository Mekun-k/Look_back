Rails.application.routes.draw do
  resources :tasks do
    collection do
      get 'today'
    end
  end

  devise_for :users, controllers: {
    omniauth_callbacks: "omniauth_callbacks"
}

  devise_scope :user do
    post 'users/guest_sign_in', to: 'users/sessions#new_guest'
  end

  root 'pages#index'

  get 'pages/show'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :api do
    resources :qiita
  end
end
